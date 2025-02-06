output "cloudfront_origin_access_identity_id" {
  value = aws_cloudfront_origin_access_identity.cloudfront_origin_access_identity.id
}

output "cloudfront_origin_access_identity_caller_reference" {
  value = aws_cloudfront_origin_access_identity.cloudfront_origin_access_identity.caller_reference
}

output "cloudfront_origin_access_identity_path" {
  value = aws_cloudfront_origin_access_identity.cloudfront_origin_access_identity.cloudfront_access_identity_path
}

output "cloudfront_origin_access_identity_etag" {
  value = aws_cloudfront_origin_access_identity.cloudfront_origin_access_identity.etag
}

output "cloudfront_origin_access_identity_iam_arn" {
  value = aws_cloudfront_origin_access_identity.cloudfront_origin_access_identity.iam_arn
}

output "cloudfront_origin_access_identity_s3_canonical_user_id" {
  value = aws_cloudfront_origin_access_identity.cloudfront_origin_access_identity.s3_canonical_user_id
}
