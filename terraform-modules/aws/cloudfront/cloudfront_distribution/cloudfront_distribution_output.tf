output "cf_id" {
  value = aws_cloudfront_distribution.cloudfront_distribution.id
}

output "cf_arn" {
  value = aws_cloudfront_distribution.cloudfront_distribution.arn
}

output "cf_caller_reference" {
  value = aws_cloudfront_distribution.cloudfront_distribution.caller_reference
}

output "cf_status" {
  value = aws_cloudfront_distribution.cloudfront_distribution.status
}

output "cf_trusted_signers" {
  value = aws_cloudfront_distribution.cloudfront_distribution.trusted_signers
}

output "cf_domain_name" {
  value = aws_cloudfront_distribution.cloudfront_distribution.domain_name
}

output "cf_last_modified_time" {
  value = aws_cloudfront_distribution.cloudfront_distribution.last_modified_time
}

output "cf_in_progress_validation_batches" {
  value = aws_cloudfront_distribution.cloudfront_distribution.in_progress_validation_batches
}

output "cf_etag" {
  value = aws_cloudfront_distribution.cloudfront_distribution.etag
}

output "cf_hosted_zone_id" {
  value = aws_cloudfront_distribution.cloudfront_distribution.hosted_zone_id
}
