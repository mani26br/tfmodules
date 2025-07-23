data "aws_region" "current" {}

data "aws_caller_identity" "current" {}


data "aws_iam_policy_document" "s3_bucket_policy_documet" {

  statement {
    sid       = "AWSCloudTrailAclCheck"
    actions   = ["s3:GetBucketAcl"]
    resources = ["${aws_s3_bucket.cloudtrail_bucket.arn}"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }

  statement {
    sid     = "AWSCloudTrailWrite"
    actions = ["s3:PutObject"]

    resources = ["${aws_s3_bucket.cloudtrail_bucket.arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

data "aws_iam_policy_document" "cloudtrail-logging-policy" {
  statement {
    sid = "WriteCloudWatchLogs"

    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
       aws_cloudwatch_log_group.cloudtrail_logs.arn
    ]
    condition {
      test = "StringEquals"
      variable = "aws:SourceAccount"
      values = ["${data.aws_caller_identity.current.account_id}"]
    }
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "kms_pol" {
    statement {
      sid = "Enable IAM User Permissions"
      
      effect  = "Allow"
      
      actions = ["kms:*"]
      
      principals {
      type        = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.aws_splunk_role_name}",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
       ]
      }

      resources = ["*"]
    }

    statement {
      sid     = "Allow CloudTrail to encrypt logs"

      effect  = "Allow"

      actions = ["kms:GenerateDataKey*"]

      principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
      }
      
      resources = ["*"]

      condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values   = ["arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"]
      }
    }

    statement {
      sid     = "Allow CloudTrail to describe key"
      effect  = "Allow"
      actions = ["kms:DescribeKey"]

      principals {
        type        = "Service"
        identifiers = ["cloudtrail.amazonaws.com"]
      }

      resources = ["*"]
    }

    statement {
      sid    = "Allow principals in the account to decrypt log files"
      effect = "Allow"

      actions = [
        "kms:Decrypt",
        "kms:ReEncryptFrom",
      ]

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      resources = ["*"]

      condition {
        test     = "StringEquals"
        variable = "kms:CallerAccount"
        values   = [data.aws_caller_identity.current.account_id]
      }

      condition {
        test     = "StringLike"
        variable = "kms:EncryptionContext:aws:cloudtrail:arn"
        values   = ["arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"]
      }
    }

    statement {
      sid     = "Allow alias creation during setup"
      effect  = "Allow"
      actions = ["kms:CreateAlias"]

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      condition {
        test     = "StringEquals"
        variable = "kms:ViaService"
        values   = ["ec2.${data.aws_region.current.name}.amazonaws.com"]
      }

      condition {
        test     = "StringEquals"
        variable = "kms:CallerAccount"
        values   = [data.aws_caller_identity.current.account_id]
      }

      resources = ["*"]
    }

    statement {
      sid    = "Enable cross account log decryption"
      effect = "Allow"

      actions = [
        "kms:Decrypt",
        "kms:ReEncryptFrom",
      ]

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      condition {
        test     = "StringEquals"
        variable = "kms:CallerAccount"
        values   = [data.aws_caller_identity.current.account_id]
      }

      condition {
        test     = "StringLike"
        variable = "kms:EncryptionContext:aws:cloudtrail:arn"
        values   = ["arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"]
      }

      resources = ["*"]
    }

    statement {
      sid    = "Allow logs KMS access"
      effect = "Allow"

      principals {
        type        = "Service"
        identifiers = ["logs.${data.aws_region.current.name}.amazonaws.com"]
      }

      actions = [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:Describe*"
      ]
      resources = ["*"]
    }

    statement {
      sid    = "Allow Cloudtrail to decrypt and generate key for sns access"
      effect = "Allow"

      principals {
        type        = "Service"
        identifiers = ["cloudtrail.amazonaws.com"]
      }

      actions = [
        "kms:Decrypt*",
        "kms:GenerateDataKey*",
      ]
      resources = ["*"]
    }
}
