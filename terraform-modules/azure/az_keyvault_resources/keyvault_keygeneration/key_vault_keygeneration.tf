resource "azurerm_key_vault_key" "generated" {
  name         = var.keyvault_keyname
  key_vault_id = var.key_vault_id
  key_type     = var.key_type
  key_size     = var.key_size
  key_opts     = var.key_opts
}
