resource "azurerm_network_interface_security_group_association" "NSG_Association" {
  network_interface_id      = var.network_interface_id
  network_security_group_id = var.network_security_group_id
}
