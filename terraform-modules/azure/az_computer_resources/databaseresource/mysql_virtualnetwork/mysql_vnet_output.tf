output "mysql_network_rule" {
  description = "mysql_network_rule Id"
  value = azurerm_mysql_virtual_network_rule.mysql_network_rule.id
}

output "mysql_subnet_id" {
  description = "Mysql servier fqdn"
  value = azurerm_mysql_virtual_network_rule.mysql_network_rule.subnet_id
}
