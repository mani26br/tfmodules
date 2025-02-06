resource "azurerm_recovery_services_vault" "vault" {
  name                = var.recovery_vault_name
  location            = var.recovery_vault_location
  resource_group_name = var.resource_group_name
  sku                 = var.recovery_vault_sku
}
