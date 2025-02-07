data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_vpcs" "current" {}

data "aws_sns_topic" "config_existing_topic" {
  name = var.config_existing_topic_name
}

data "aws_guardduty_detector" "guardduty" {}


###Guardduty_Policies###

data "aws_iam_policy_document" "gd_sqs_queue_policy" {
  version = "2012-10-17"
  statement {
    sid    = "First"
    actions = [
      "sqs:SendMessage"
    ]
    resources = [
      module.sqs_guardduty.base_queue_arn
    ]
    condition {
      test = "ArnEquals"
      variable = "aws:SourceArn"
      values = ["${module.sns_guardduty_notifications.sns_topic_arn}"]
    }
    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    } 

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "gd_sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        "${data.aws_caller_identity.current.account_id}"
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      module.sns_guardduty_notifications.sns_topic_arn,
    ]

    sid = "__default_statement_ID"
  }
  statement {
    sid = "Allow eventbridge to publish findings"
    actions = [
      "sns:Publish"
    ]
    resources = [
      module.sns_guardduty_notifications.sns_topic_arn
    ]
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    effect = "Allow"
  }
}


###Config_Policies###

data "aws_iam_policy_document" "config_sqs_queue_policy" {
  version = "2012-10-17"
  statement {
    sid    = "First"
    actions = [
      "sqs:SendMessage"
    ]
    resources = [
      module.sqs_aws_config.base_queue_arn
    ]
    condition {
      test = "ArnEquals"
      variable = "aws:SourceArn"
      values = ["${data.aws_sns_topic.config_existing_topic.arn}"]
    }
    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    } 

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "config_sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        "${data.aws_caller_identity.current.account_id}"
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      "${data.aws_sns_topic.config_existing_topic.arn}"
    ]

    sid = "__default_statement_ID"
  }
  statement {
    sid = "Allow eventbridge to publish findings"
    actions = [
      "sns:Publish"
    ]
    resources = [
      "${data.aws_sns_topic.config_existing_topic.arn}"
    ]
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    effect = "Allow"
  }
}


####VPC_flow_log_policies###

data "aws_iam_policy_document" "vpc_flow_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "flow_log_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]
    
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:*"]
  }
}

###SGC_S3_Bucket_Policy###
data "aws_iam_policy_document" "aws_ssm_sgc_s3_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ssm.amazonaws.com"]
    }
    principals {
      type        = "AWS"
      identifiers = ["${data.aws_caller_identity.current.account_id}"]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
 
    resources = ["arn:aws:s3:::${var.aws_ssm_sgc_bucket_name}", "arn:aws:s3:::${var.aws_ssm_sgc_bucket_name}/*"]
  }
}

###AWS_System_Manager_ec2_policy###
data "aws_iam_policy_document" "aws_ssm_ec2_policy" {

  statement {
    sid = "PublishSyslogsToCloudWatchLogs"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:*"
    ]
  }
  statement {
    sid = "PublishSSMResultsToS3"
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:PutObjectAcl"
    ]
    resources = [
      #"arn:aws:s3:::${var.aws_ssm_bucket_name}/*",
      "arn:aws:s3:::${var.aws_ssm_sgc_bucket_name}/*"
    ]
  }
}