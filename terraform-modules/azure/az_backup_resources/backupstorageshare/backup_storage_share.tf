resource "azurerm_storage_share" "backup_storage_share" {
  name                 = var.backup_protected_file_share_source_file_share_name
  storage_account_name = var.storage_account_name
}
