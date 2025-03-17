module "azurerm_storage_account" {
    source = "../../terraform-modules/azure/az_storageresources/storageaccount"
    storage_account_name        = var.storage_account_name
    storage_account_resource_group_name = var.storage_account_resource_group_name
    storage_account_location    = var.storage_account_location
    storage_account_account_tier = var.storage_account_account_tier
    storage_account_tags = var.common_tags
}
