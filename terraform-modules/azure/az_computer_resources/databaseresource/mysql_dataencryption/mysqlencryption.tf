resource "azurerm_mysql_server_key" "mysql_server_key" {
  server_id        = var.mysql_id
  key_vault_key_id = var.key_vault_key_url
}
