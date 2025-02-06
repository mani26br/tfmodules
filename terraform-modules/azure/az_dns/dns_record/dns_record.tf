resource "azurerm_dns_a_record" "dns_a_record" {
  name                = var.dns_record_name
  zone_name           = var.dns_name
  resource_group_name = var.resource_group_name
  ttl                 = var.TimeToLive_seconds
  target_resource_id  = var.dns_public_ip
}
