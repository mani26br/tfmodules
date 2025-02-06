data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "s3_bucket_policy_documet" {
  statement {
    sid = "AWSConfigBucketPermissionsCheck"
    actions = [
      "s3:GetBucketAcl"
    ]

    resources = [
      "${aws_s3_bucket.configbucket.arn}"
    ]

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    effect = "Allow"
  }

  statement {
    sid = "AWSConfigBucketDelivery"
    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.configbucket.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/Config/*"
    ]

    condition {
      test = "StringEquals"
      variable = "s3:x-amz-acl"
      values = ["bucket-owner-full-control"]
    }

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    effect = "Allow"
  }
}
