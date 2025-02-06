resource "azurerm_key_vault_access_policy" "keyvault_accesspolicy" {
  key_vault_id = var.keyvault-id
  tenant_id = var.tenant-id
  object_id = var.object-id
  application_id = var.application-id
  certificate_permissions = var.certificate-permissions
  key_permissions = var.key-permissions
  secret_permissions = var.secret-permissions
  storage_permissions = var.storage-permissions
}
