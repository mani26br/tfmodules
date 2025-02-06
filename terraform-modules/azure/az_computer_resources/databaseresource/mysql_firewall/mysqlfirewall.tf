resource "azurerm_mysql_firewall_rule" "firewall" {
  name                = var.firewall_rule_name
  resource_group_name = var.resource_group_name
  server_name         = var.mysql_server_name
  start_ip_address    = var.start_ip_address
  end_ip_address      = var.end_ip_address
}
