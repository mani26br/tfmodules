data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_vpcs" "current" {}

###EIC_Endpoint_Assume_Role_Policies###
data "aws_iam_policy_document" "EIC_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::265129476828:user/aws-strides-snow-sgc-user"]
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
      module.lambda_function_compliance_report.lambda_function_arn
    ]
  }
}