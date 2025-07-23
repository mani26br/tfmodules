resource "aws_wafv2_web_acl_association" "wafv2_web_acl_association" {
  resource_arn = var.wafv2_web_acl_association_resource_arn
  web_acl_arn  = var.wafv2_web_acl_association_web_acl_arn
}
