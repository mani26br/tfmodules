output "key-vault-secret-id" {
  description = "Key Vault ID"
  value       = azurerm_key_vault_secret.key_vault_secret.id
}
