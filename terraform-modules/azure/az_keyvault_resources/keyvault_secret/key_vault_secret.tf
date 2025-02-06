resource "azurerm_key_vault_secret" "key_vault_secret" {
  name         = var.key_vault_secret_name
  value        = var.key_vault_secret_value
  key_vault_id = var.key_vault_id
  expiration_date = var.expiration_date
}
