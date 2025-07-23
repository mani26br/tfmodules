resource "aws_config_configuration_recorder_status" "confgirecorderstatus" {
  name       = var.aws_config_recorder
  is_enabled = true
  depends_on = [aws_config_delivery_channel.configdelivery]
}

resource "aws_s3_bucket" "configbucket" {
  bucket = var.aws_config_s3_bucket
  tags   = merge(tomap({
  "Name" = var.aws_config_s3_bucket,
  }), var.s3_bucket_tags)
}

resource "aws_s3_bucket_ownership_controls" "config_bucket" {
  bucket = aws_s3_bucket.configbucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "configbucket_acl" {
  bucket = aws_s3_bucket.configbucket.id
  acl    = "private"
  depends_on = [aws_s3_bucket_ownership_controls.config_bucket]
}

resource "aws_s3_bucket_versioning" "config_versioning" {
  bucket = aws_s3_bucket.configbucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "configbucket_policy" {
  bucket = aws_s3_bucket.configbucket.id
  policy = data.aws_iam_policy_document.s3_bucket_policy_documet.json
}

resource "aws_config_delivery_channel" "configdelivery" {
  name           = var.aws_configdelivery
  s3_bucket_name = var.aws_config_s3_bucket
  sns_topic_arn = var.aws_config_sns_topic_arn
  depends_on = [aws_config_configuration_recorder.configrecorder,aws_s3_bucket.configbucket]
}

resource "aws_iam_service_linked_role" "configrole" {
  count = var.aws_iam_service_linked_role ? 1 : 0
  aws_service_name = "config.amazonaws.com"
}

resource "aws_config_configuration_recorder" "configrecorder" {
  name     = var.aws_config_recorder
  role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/config.amazonaws.com/AWSServiceRoleForConfig"
}
