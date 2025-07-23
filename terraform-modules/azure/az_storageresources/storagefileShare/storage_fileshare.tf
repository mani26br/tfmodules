resource "azurerm_storage_share" "fileshare" {
name                 = var.fileshare_name
storage_account_name = var.storage_account_name
quota                = var.quota_id
dynamic "acl" {
  for_each = var.aclid

  content {
    id = var.fileshare_aclid

      dynamic "access_policy" {
       for_each = var.access_policy

       content {
         permissions = var.permissions
         start       = var.startdate
         expiry      = var.expirydate
      }
    }
  }
}
}
