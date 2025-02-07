
resource "aws_s3_bucket" "guardduty_logs" {
  bucket = var.guardduty_logs_s3_bucket
}

resource "aws_s3_bucket_ownership_controls" "guardduty_bucket" {
  bucket = aws_s3_bucket.guardduty_logs.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "gd_bucket_acl" {
  bucket = aws_s3_bucket.guardduty_logs.id
  acl    = "private"
  depends_on = [aws_s3_bucket_ownership_controls.guardduty_bucket]
}

resource "aws_s3_bucket_policy" "gd_bucket_policy" {
  bucket = aws_s3_bucket.guardduty_logs.id
  policy = data.aws_iam_policy_document.bucket_pol.json
}

resource "aws_kms_key" "gd_key" {
  key_usage               = "ENCRYPT_DECRYPT"
  description             = "KMS Key for the Guardduty"
  deletion_window_in_days = 7
  policy                  = data.aws_iam_policy_document.kms_pol.json
}

resource "aws_kms_alias" "gd_kms_alias" {
  name          = var.gd_kms_alias_name
  target_key_id = aws_kms_key.gd_key.id
}

resource "aws_guardduty_publishing_destination" "gd_publishing" {
  detector_id     = var.aws_gddetector_id
  destination_arn = aws_s3_bucket.guardduty_logs.arn
  kms_key_arn     = aws_kms_key.gd_key.arn

  depends_on = [
    aws_s3_bucket_policy.gd_bucket_policy,
  ]
}

resource "aws_cloudwatch_event_rule" "guarddutyevent" {
  name        = var.guarddutyevent_name
  description = var.guarddutyevent_description
  is_enabled  = var.guardduty_enabled
  event_pattern = file("${path.module}/event-pattern.json")
  tags        = var.tags
}

resource "aws_cloudwatch_event_target" "guarddutyeventtarget" {
  rule      = aws_cloudwatch_event_rule.guarddutyevent.name
  arn       = var.notification_arn
  input_transformer {
    input_paths = {
      Account_ID  = "$.detail.accountId"
      Finding_ID  = "$.detail.id"
      Finding_Type = "$.detail.type"
      Finding_description = "$.detail.description"
      region      = "$.detail.region"
      severity    = "$.detail.severity"
    }
    input_template = <<-EOT
      "AWS <Account_ID> has a severity <severity> GuardDuty finding type <Finding_Type> in the <region> region."
      "Finding Description:<Finding_description>."
      "For more details open the GuardDuty console at https://console.aws.amazon.com/guardduty/home?region=<region>#/findings?search=id=<Finding_ID>"
    EOT
  }
}