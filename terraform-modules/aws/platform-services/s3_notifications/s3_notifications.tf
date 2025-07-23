resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = var.aws_s3_notification_bucket

  queue {
    filter_prefix = var.bucket_prefix
    queue_arn     = var.aws_s3_bucket_notification_queue
    events        = ["s3:ObjectCreated:*"]
  }
}
