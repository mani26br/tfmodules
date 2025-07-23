resource "azurerm_managed_disk" "managed_disk" {
  name                 = var.managed_disk_name
  location             = var.resource_group_location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.storage_account_type
  create_option        = var.create_option
  disk_size_gb         = var.disk_size_gb

  tags = "${merge(tomap(
    "Name", "${var.managed_disk_name}",
    "resource_group_name", "${resource_group_name}"
    ),)}"
}

}
