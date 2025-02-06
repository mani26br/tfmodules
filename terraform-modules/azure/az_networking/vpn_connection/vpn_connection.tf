resource "azurerm_virtual_network_gateway_connection" "onpremise" {
  name                           = var.vpn_connection_name
  location                       = var.resource_group_location
  resource_group_name            = var.resource_group_name

  type                           = var.ipsec_type
  virtual_network_gateway_id     = var.virtual_network_gateway_id
  local_network_gateway_id       = var.local_network_gateway_id
  dpd_timeout_seconds            = var.dpd_timeout_seconds
  local_azure_ip_address_enabled = var.local_azure_ip_address_enabled
  enable_bgp                     = var.enable_bgp
  express_route_gateway_bypass   = var.express_route_gateway_bypass
  use_policy_based_traffic_selectors = var.use_policy_based_traffic_selectors
  shared_key                     = var.shared_key
  routing_weight                 = var.routing_weight
}
