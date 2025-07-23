resource "aws_wafv2_ip_set" "wafv2_ip_set" {
  name               = var.wafv2_ip_set_name
  description        = var.wafv2_ip_set_description
  scope              = var.wafv2_ip_set_scope
  ip_address_version = var.wafv2_ip_address_version
  addresses          = var.wafv2_ip_set_addresses

  tags = merge(map(
    "Name", var.wafv2_ip_set_name,
  ), var.wafv2_ip_set_tags)

}
