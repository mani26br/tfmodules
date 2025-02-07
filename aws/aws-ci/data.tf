data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_vpcs" "current" {}

###S3_replication_role###

data "aws_iam_policy_document" "s3_replication_assume_role_policy" {
  statement {
    sid = "s3ReplicationAssume"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

###s3_tfstate_replication_policy####

data "aws_s3_bucket" "existing_tfstate_bucket" {
  bucket = var.existing_tfstate_bucket_name
}

data "aws_iam_policy_document" "s3_tfstate_replication_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetReplicationConfiguration",
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
      "s3:GetObjectRetention",
      "s3:GetObjectLegalHold"
    ]
    
    resources = [
      "arn:aws:s3:::${var.existing_tfstate_bucket_name}",
      "arn:aws:s3:::${var.existing_tfstate_bucket_name}/*",
      "arn:aws:s3:::${var.destination_tfstate_bucket_name}",
      "arn:aws:s3:::${var.destination_tfstate_bucket_name}/*"
    ]
  }
  statement {
    effect = "Allow"

    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags",
      "s3:ObjectOwnerOverrideToBucketOwner"
    ]
    
    resources = [
      "arn:aws:s3:::${var.existing_tfstate_bucket_name}/*",
      "arn:aws:s3:::${var.destination_tfstate_bucket_name}/*"
    ]
  }
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
      values = ["${module.sns_aws_config_notifications.sns_topic_arn}"]
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
      module.sns_aws_config_notifications.sns_topic_arn,
    ]

    sid = "__default_statement_ID"
  }
  statement {
    sid = "Allow eventbridge to publish findings"
    actions = [
      "sns:Publish"
    ]
    resources = [
      module.sns_aws_config_notifications.sns_topic_arn
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

###AWS_System_Manager_S3_Bucket_Policy###
data "aws_iam_policy_document" "aws_ssm_s3_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ssm.amazonaws.com"]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
 
    resources = ["arn:aws:s3:::${var.aws_ssm_bucket_name}/*"]
  }
}

###SNOW_SGC_Organization_Role_Policy###
data "aws_iam_policy_document" "sgc_organization_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::082241233635:user/snow_sgc_connector"]
    }

    actions = ["sts:AssumeRole"]
    
    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalOrgID"

      values = ["o-mmhduiwcz0"]
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

    resources = ["arn:aws:s3:::aws-ci-snow-sgc-data/*"]
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
      "arn:aws:s3:::${var.aws_ssm_bucket_name}/*"
    ]
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

###Compliance_Report_User###

data "aws_iam_policy_document" "compliance_user_policy" {
  version = "2012-10-17"
  statement {
    sid    = "First"
    actions = [
      "sts:AssumeRole",
      "sts:GetFederationToken",
      "sts:AssumeRoleWithSAML",
      "sts:AssumeRoleWithWebIdentity"
    ]
    resources = ["arn:aws:iam::063208468694:role/GetComplianceReportsRole"]
    effect = "Allow"
  }
  statement {
    sid    = "Second"
    actions = [
      "sts:GetSessionToken",
      "sts:DecodeAuthorizationMessage",
      "sts:GetAccessKeyInfo",
      "sts:GetCallerIdentity"
    ]
    resources = ["arn:aws:iam::063208468694:role/GetComplianceReportsRole"]
    effect = "Allow"
  }
}

data "aws_iam_policy_document" "GetComplianceReportsRole_assumerole_trust_policy" {
  version = "2012-10-17"
  statement {
    sid    = "First"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::063208468694:user/compliance-report-user"]
    }
    effect = "Allow"
  }
}


data "aws_iam_policy_document" "AssumeCrossAccountComplianceReportsRole_policy_permissions" {
  version = "2012-10-17"
  statement {
    sid    = "First"
    actions = [
      "sts:AssumeRole"
    ]
    resources = var.compliance_report_assume_roles
    effect = "Allow"
  }
  statement {
    sid    = "Second"
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

###AWS S3 Access Logs#####

data "aws_iam_policy_document" "accesslogs_queue_policy" {
  version = "2012-10-17"
  statement {
    sid    = "First"
    actions = [
      "sqs:SendMessage"
    ]
    resources = [
      module.sqs_accesslogs_sqs_queue.base_queue_arn
    ]
    condition {
      test = "ArnEquals"
      variable = "aws:SourceArn"
      values = ["${module.aws_s3_accesslogs_destination_bucket.s3_bucket_arn}"]
    }
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    } 

    effect = "Allow"
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
      identifiers = ["arn:aws:iam::063208468694:user/compliance-report-user"]
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

###SSM_Session_KMS_Key_Policy###
data "aws_iam_policy_document" "kms_ssm_session" {
  statement {
    sid = "Enable IAM User Permissions"
    effect = "Allow"
    actions = ["kms:*"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["${var.IAM_role_arn}"] 
    }
  }
  statement {
    sid       = "Allow Use Of Key"
    effect    = "Allow"
    actions   = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
      "kms:GetKeyPolicy",
      "kms:GetKeyRotationStatus",
      "kms:ListResourceTags",
    ]
    resources = ["*"]
  
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

###EIC_Endpoint_Assume_Role_Policies###
data "aws_iam_policy_document" "EIC_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
        "arn:aws:iam::265129476828:user/aws-strides-snow-sgc-user"
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}

###EIC_Endpoint###

data "aws_iam_policy_document" "EIC_role_policy" {
  statement {
    effect = "Allow"
    actions = [
      "ec2-instance-connect:OpenTunnel",
    ]

    resources = ["arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance-connect-endpoint/*"]

    condition {
      test = "StringEquals"
      variable = "aws:ResourceTag/access-team"
      values = [var.common_tags["access-team"]]
    }
  }
  dynamic "statement" {
    for_each = {
    for key, value in var.EIC_vpc_ids : key => value
    }
    content {
    effect = "Allow"
    actions = [
      "ec2-instance-connect:SendSSHPublicKey",
    ]
    resources = ["arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance/*"]

    condition {
      test = "StringEquals"
      variable = "aws:ResourceTag/access-team"
      values = [var.common_tags["access-team"]]
    }

    condition {
      test = "StringEquals"
      variable = "aws:ResourceTag/project"
      values = statement.value.project_tags
    }
  }
  }
  statement {
    sid = "Describe"
    effect = "Allow"
    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceConnectEndpoints"
    ]
    resources = ["*"]
}
}

###EIC_SG_Attachment_Lambda_Function####

data "aws_iam_policy_document" "lambda_eic_sg_attachment_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "eic_sg_attachment_role_policy" {
  statement {
    actions   = [
      "ec2:ModifyInstanceAttribute",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeInstances"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}


###SNOW_Mid_Server_CUR_Policy### 
data "aws_iam_policy_document" "SNOW_MID_CUR_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::905365839001:role/snow-mgmt-cur-role"]
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

###Start/Stop_EC2_Automation_Role_Policies###
data "aws_iam_policy_document" "automation_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ssm.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}


data "aws_iam_policy_document" "automation_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "ssm:*",
      "ec2:StartInstances",
      "ec2:StopInstances",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeTags",
      "resource-groups:*",
      "tag:getResources",
      "tag:getTagKeys",
      "tag:getTagValues",
    ]

    resources = ["*"]
  }
  statement {
    effect = "Allow"

    actions = [
      "lambda:InvokeFunction",
    ]

    resources = [module.lambda_function_sns_mw.lambda_function_arn]
  }
}

###Start_Stop_EC2_Lambda_Role_Policies###
data "aws_iam_policy_document" "lambda_start_stop_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}


data "aws_iam_policy_document" "lambda_start_stop_role_policy" {
statement {
    effect = "Allow"

    actions = [
      "sns:Publish" #start-stop notification
    ]

    resources = ["arn:aws:sns:us-east-1:${data.aws_caller_identity.current.account_id}:aws-ci-itrb-notification"]
  }
}

###Eventbridge_scheduler_role_policy###
data "aws_iam_policy_document" "eventbridge_scheduler_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["scheduler.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}


data "aws_iam_policy_document" "eventbridge_scheduler_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "lambda:InvokeFunction"
    ]

    resources = [
      module.lambda_function_compliance_report.lambda_function_arn,
      module.lambda_function_cost_report.lambda_function_arn
    ]
  }
}