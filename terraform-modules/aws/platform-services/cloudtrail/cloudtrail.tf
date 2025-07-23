resource "aws_s3_bucket" "cloudtrail_bucket" {
  bucket = var.aws_cloudtrail_bucket
  tags   = merge(tomap({
  "Name" = var.aws_cloudtrail_bucket,
  }), var.s3_bucket_tags)
}

resource "aws_s3_bucket_ownership_controls" "cloudtrail_bucket" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "cloudtrail_bucket_acl" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id
  acl    = "private"
  depends_on = [aws_s3_bucket_ownership_controls.cloudtrail_bucket]
}

resource "aws_s3_bucket_versioning" "config_versioning" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "configbucket_policy" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id
  policy = data.aws_iam_policy_document.s3_bucket_policy_documet.json
}


resource "aws_cloudwatch_log_group" "cloudtrail_logs" {
  name = "/aws/cloudtrail/${data.aws_caller_identity.current.id}/${var.environment}/cloudtrail_logs/"
  retention_in_days = var.retention_period
  tags = merge(tomap({
  "Name" = "/aws/cloudtrail/${data.aws_caller_identity.current.id}/${var.environment}/cloudtrail_logs/",
  }), var.cloudtrail_tags)
}

resource "aws_cloudwatch_log_resource_policy" "cloudtrail-logging-policy" {
  policy_document = data.aws_iam_policy_document.cloudtrail-logging-policy.json
  policy_name = "cloudtrail-logging-policy"
}

data "aws_iam_policy_document" "cloudtrail_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "cloudtrail_cloudwatch_role" {
  name               = var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.cloudtrail_assume_role.json
}

resource "aws_iam_policy_attachment" "cloudtrail_cloudwatch_logs_attachment" {
  name       = "cloudtrail-cloudwatch-logs-attachment"
  roles      = [aws_iam_role.cloudtrail_cloudwatch_role.name]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_kms_key" "cloudtrail_key" {
  key_usage               = "ENCRYPT_DECRYPT"
  description             = "KMS Key for the Cloudtrail"
  deletion_window_in_days = 7
  policy                  = data.aws_iam_policy_document.kms_pol.json
}

resource "aws_kms_alias" "cloudtrail_alias" {
  name          = var.cloudtrail_alias_name
  target_key_id = aws_kms_key.cloudtrail_key.id
}

resource "aws_cloudtrail" "default" {
  count = var.enabled_cloudtrail ? 1 : 0
  name                          = var.trail_name
  enable_logging                = var.enable_logging
  s3_bucket_name                = aws_s3_bucket.cloudtrail_bucket.id
  enable_log_file_validation    = var.enable_log_file_validation
  is_multi_region_trail         = var.is_multi_region_trail
  include_global_service_events = var.include_global_service_events
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail_cloudwatch_role.arn
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.cloudtrail_logs.arn}:*"
  kms_key_id                    = aws_kms_key.cloudtrail_key.arn
  is_organization_trail         = var.is_organization_trail
  sns_topic_name                = var.sns_topic_name
  depends_on                    = [aws_cloudwatch_log_group.cloudtrail_logs,aws_iam_role.cloudtrail_cloudwatch_role]
  tags                          = merge(tomap({
  "Name"                        = var.trail_name,
                                }), var.cloudtrail_tags)
}
