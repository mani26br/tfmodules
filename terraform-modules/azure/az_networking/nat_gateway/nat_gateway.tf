resource "azurerm_nat_gateway" "nat_gateway" {
  name = var.nat_gateway_name
  resource_group_name = var.nat_gateway_resource_group_name
  location = var.nat_gateway_location
  idle_timeout_in_minutes = var.nat_gateway_idle_timeout_min
  #public_ip_address_ids = var.nat_gateway_public_ip_add
  #public_ip_prefix_ids = var.nat_gateway_public_ip_prefix
  sku_name = var.nat_gateway_sku_name
  tags = tomap(var.nat_gateway_tags)
  zones = var.nat_gateway_zones
}
