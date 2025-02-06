resource "azurerm_backup_container_storage_account" "backup_container_storage_account" {
  resource_group_name = var.backup_container_resource_group_name
  recovery_vault_name = var.backup_container_recovery_vault_name
  storage_account_id = var.backup_container_source_storage_account_id
}
