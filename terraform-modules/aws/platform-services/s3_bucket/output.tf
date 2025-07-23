output "s3_bucket_name" {
  description = "The name of the created S3 bucket"
  value       = aws_s3_bucket.this.id
}

output "s3_bucket_arn" {
  description = "The ARN (Amazon Resource Name) of the created S3 bucket"
  value       = aws_s3_bucket.this.arn
}

output "s3_bucket_region" {
  description = "The region in which the S3 bucket was created"
  value       = aws_s3_bucket.this.region
}