resource "aws_s3_bucket_logging" "this" {
  bucket = var.source_logging_bucket
  target_bucket = var.target_bucket_name
  target_prefix = var.target_prefix
}
