resource "aws_s3_bucket" "this" {
  bucket              = var.bucket
  tags                = merge(tomap({
    "Name" = var.bucket,
    }), var.bucket_tags)
}

resource "aws_s3_bucket_object" "storage" {
  count = var.aws_s3_bucket_object_storage ? 1:0
  bucket = var.bucket
  key = var.s3_bucket_prefix
  depends_on = [aws_s3_bucket.this]
} 

resource "aws_s3_bucket_policy" "policy" {
  count = var.create_aws_s3_bucket_policy ? 1:0

  bucket = aws_s3_bucket.this.id
  policy = var.policy
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_acl" "acl" {
  count = var.create_aws_s3_bucket_acl ? 1:0

  bucket = aws_s3_bucket.this.id
  acl    = "private"
  depends_on = [aws_s3_bucket_ownership_controls.ownership]
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_master_key_id
      sse_algorithm     = var.sse_algorithm
    }
  }
}

