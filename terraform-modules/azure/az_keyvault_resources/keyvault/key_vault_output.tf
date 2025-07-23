/* OLD CODE BUT WORKING */
/*
output "key_vault_id" {
  description = "key vault id"
  value = azurerm_key_vault.key_vault.id
}
output "key_vault_vault_uri" {
  description = "key vault uri"
  value = azurerm_key_vault.key_vault.vault_uri
}
*/

output "key-vault-id" {
  description = "Key Vault ID"
  value       = azurerm_key_vault.key_vault.id
}

output "key-vault-url" {
  description = "Key Vault URI"
  value       = azurerm_key_vault.key_vault.vault_uri
}

output "key-vault-secrets" {
  value = values(azurerm_key_vault_secret.secret).*.value
}
