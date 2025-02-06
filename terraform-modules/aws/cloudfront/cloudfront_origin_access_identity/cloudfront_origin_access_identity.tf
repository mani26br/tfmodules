resource "aws_cloudfront_origin_access_identity" "cloudfront_origin_access_identity" {
  comment = var.cloudfront_origin_access_identity_comments
}
