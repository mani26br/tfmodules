resource "azurerm_mysql_virtual_network_rule" "mysql_network_rule" {
  name = "${var.mysql_vnet_name}"
  resource_group_name = "${var.mysql_server_resource_group_name}"
  server_name = "${var.mysql_server_name}"
  subnet_id = "${var.mysql_subnet_id}"
}
