output "nat_gateway_id" {
  description = "virtual network Id"
  value = azurerm_nat_gateway.nat_gateway.id
}

output "nat_gateway_resource_guid" {
  description = "virtual network Id"
  value = azurerm_nat_gateway.nat_gateway.resource_guid
}
