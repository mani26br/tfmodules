output "vpn_connection_id" {
  description = "vpn connection Id"
  value = azurerm_virtual_network_gateway_connection.onpremise.id
}
