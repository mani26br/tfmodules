output "des_id" {
  description = "DES - ID"
  value = azurerm_disk_encryption_set.diskencryptionset.id
}

output "des_identity" {
  description = "DES - Identity"
  value = azurerm_disk_encryption_set.diskencryptionset.identity
}
