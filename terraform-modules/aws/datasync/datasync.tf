resource "aws_datasync_location_s3" "s3_datasync_source_location" {
  s3_bucket_arn = var.source_s3_bucket_arn
  subdirectory  = var.source_prefix

  s3_config {
    bucket_access_role_arn = var.iam_role_arn
  }
}

resource "aws_datasync_location_s3" "s3_datasync_destination_location" {
  s3_bucket_arn = var.destination_s3_bucket_arn
  subdirectory  = var.destination_prefix

  s3_config {
    bucket_access_role_arn = var.iam_role_arn
  }
}

resource "aws_datasync_task" "datasync_task" {
  destination_location_arn = aws_datasync_location_s3.s3_datasync_destination_location.arn
  name                     = "S3_datasync"
  source_location_arn      = aws_datasync_location_s3.s3_datasync_source_location.arn
}
