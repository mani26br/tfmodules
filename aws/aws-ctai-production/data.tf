data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_vpcs" "current" {}
/*
data "aws_sns_topic" "config_existing_topic" {
  name = var.config_existing_topic_name
}


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

*/
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

###SNOW_SGC_Organization_Role_Policy###
data "aws_iam_policy_document" "sgc_organization_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::454343540246:user/snow_sgc_connector"]
    }

    actions = ["sts:AssumeRole"]

    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalOrgID"

      values = ["o-4ffgzd99rv"]
    }
  }
}


data "aws_iam_policy_document" "sgc_organization_role_policy" {
  statement {
    sid = "ServiceNowUserReadOnlyAccess"
    effect = "Allow"
    actions = [
      "organizations:DescribeOrganization",
      "organizations:ListAccounts",
      "config:ListDiscoveredResources",
      "config:SelectAggregateResourceConfig",
      "config:BatchGetAggregateResourceConfig",
      "config:SelectResourceConfig",
      "config:BatchGetResourceConfig",
      "ec2:DescribeRegions",
      "ec2:DescribeImages",
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceTypes",
      "ssm:DescribeInstanceInformation",
      "ssm:ListInventoryEntries",
      "ssm:GetInventory",
      "ssm:SendCommand",
      "s3:GetObject",
      "s3:DeleteObject",
      "tag:GetResources"
    ]

    resources = ["*"]
  }
  statement {
    sid = "SendCommandAccess"
    effect = "Allow"
    actions = [
      "ssm:SendCommand"
    ]

    resources = [
      "arn:aws:ec2:*:*:instance/*",
      "arn:aws:ssm:*:*:document/SG-AWS-RunShellScript",
      "arn:aws:ssm:*:*:document/SG-AWS-RunPowerShellScript"
    ]
  }
  statement {
    sid = "S3BucketAccess"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:DeleteObject"
    ]

    resources = ["arn:aws:s3:::${var.aws_ssm_sgc_bucket_name}/*"]
  }
}

###Compliance_Report_Lambda_Role_Policies###
data "aws_iam_policy_document" "lambda_compliance_report_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}


data "aws_iam_policy_document" "lambda_compliance_report_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:ListBucketVersions",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "config:GetComplianceDetailsByConfigRule",
      "config:StartConfigRulesEvaluation"
    ]

    resources = [
      "arn:aws:s3:::${var.compliance_report_bucket_name}/*",
      "arn:aws:s3:::${var.compliance_report_bucket_name}",
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:*",
      "arn:aws:config:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:config-rule/*"
    ]
  }
}

###Compliance_Report_Role###

data "aws_iam_policy_document" "compliance_user_assumerole_trust_policy" {
  version = "2012-10-17"
  statement {
    sid    = "First"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::063208468694:role/GetComplianceReportsRole"]
    }
    effect = "Allow"
  }
}


data "aws_iam_policy_document" "compliance_user_role_policy_permissions" {
  version = "2012-10-17"
  statement {
    sid    = "First"
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "arn:aws:s3:::${var.compliance_report_bucket_name}/*",
      "arn:aws:s3:::${var.compliance_report_bucket_name}"
    ]
    effect = "Allow"
  }
}

###Cost-Reports###

data "aws_iam_policy_document" "lambda_cost_report_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "lambda_cost_report_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:ListBucketVersions",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "config:GetComplianceDetailsByConfigRule",
      "config:StartConfigRulesEvaluation"
    ]

    resources = [
      "arn:aws:s3:::${var.cost_report_bucket_name}/*",
      "arn:aws:s3:::${var.cost_report_bucket_name}",
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:*",
      "arn:aws:config:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:config-rule/*"
    ]
  }
  statement {
    effect = "Allow"

    actions = [
      "ce:GetCostAndUsageWithResources",
      "ec2:DescribeTags"
    ]
    
    resources = ["*"]
  }
}

