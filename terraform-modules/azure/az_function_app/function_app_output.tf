output "function_app_id" {
  value = azurerm_function_app.function_app.id
}

output "function_app_custom_domain_verification_id" {
  value = azurerm_function_app.function_app.custom_domain_verification_id
}

output "function_app_default_hostname" {
  value = azurerm_function_app.function_app.default_hostname
}

output "function_app_outbound_ip_addresses" {
  value = azurerm_function_app.function_app.outbound_ip_addresses
}

output "function_app_possible_outbound_ip_addresses" {
  value = azurerm_function_app.function_app.possible_outbound_ip_addresses
}

output "function_app_identity" {
  value = azurerm_function_app.function_app.identity
}

output "function_app_site_credential" {
  value = azurerm_function_app.function_app.site_credential
}

output "function_app_kind" {
  value = azurerm_function_app.function_app.kind
}
