resource "azurerm_frontdoor_custom_https_configuration" "azurerm_frontdoor_custom_https_configuration" {
  frontend_endpoint_id              = var.custom_frontend_endpoint
  custom_https_provisioning_enabled = var.custom_https_provisioning_enabled
  
  dynamic "custom_https_configuration" {
    for_each = var.custom_https_configuration
    
    content {
     certificate_source = "${lookup(custom_https_configuration.value, "certificate_source", null)}"
     azure_key_vault_certificate_secret_name = "${lookup(custom_https_configuration.value, "azure_key_vault_certificate_secret_name", null)}"
     azure_key_vault_certificate_vault_id = "${lookup(custom_https_configuration.value, "azure_key_vault_certificate_vault_id", null)}"
  }
}
}