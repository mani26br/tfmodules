resource "azurerm_virtual_network_peering" "vnetpeering" {
  name                         = var.virtual_network_peering_name
  virtual_network_name         = var.virtual_network_name
  resource_group_name          = var.resource_group_name
  remote_virtual_network_id    = var.remote_virtual_network_id 
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic      
  allow_gateway_transit        = var.allow_gateway_transit
}
