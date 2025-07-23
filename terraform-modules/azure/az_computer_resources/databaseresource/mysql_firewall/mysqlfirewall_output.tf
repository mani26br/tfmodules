output "mysql_firewall_rule" {
  description = "mysql_firewall_rule Id"
  value = azurerm_mysql_firewall_rule.firewall.id
}
