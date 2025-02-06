output "frontdoor_id" {
 description = "azure front door id"
 value = azurerm_frontdoor.frontdoor.id
}

output "frontdoor_endpoint" {
 description = "azure front door endpoint"
 value = azurerm_frontdoor.frontdoor.frontend_endpoints
}
