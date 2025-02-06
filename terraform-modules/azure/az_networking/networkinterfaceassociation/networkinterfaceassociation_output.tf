output "network_interface_association_id" {
  description = "Please find the NSG association id"
  value = azurerm_network_interface_security_group_association.NSG_Association.id
}
