output "key-vault-key-id" {
  description = "Key Vault ID"
  value       = azurerm_key_vault_key.generated.id
}
