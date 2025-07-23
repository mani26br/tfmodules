resource "azurerm_mysql_server" "mysql_server" {
  name = "${var.mysql_server_name}"
  resource_group_name = "${var.mysql_server_resource_group_name}"
  location = "${var.mysql_server_location}"
  sku_name = "${var.mysql_server_sku_name}"

  dynamic "storage_profile" {
    for_each = "${var.mysql_server_storage_profile}"

    content {
      storage_mb = "${lookup(storage_profile.value, "storage_mb", null)}"
      backup_retention_days = "${lookup(storage_profile.value, "backup_retention_days", null)}"
      geo_redundant_backup = "${lookup(storage_profile.value, "geo_redundant_backup", null)}"
      auto_grow = "${lookup(storage_profile.value, "auto_grow", null)}"
    }
  }

  administrator_login = "${var.mysql_server_administrator_login}"
  administrator_login_password = "${var.mysql_server_administrator_login_password}"
  version = "${var.mysql_server_version}"
  ssl_enforcement = "${var.mysql_server_ssl_enforcement}"
  public_network_access_enabled     = var.public_network_access_enabled

  dynamic "identity" {
    for_each = "${var.mysql_identity}"

	content {
	  type = "${lookup(identity.value, "type", null)}"
    }
 }

  tags = "${merge(tomap(
    "Name", "${var.mysql_server_name}",
    "resource_group_name", "${var.mysql_server_resource_group_name}",
    ), var.mysql_server_tags)}"
}
