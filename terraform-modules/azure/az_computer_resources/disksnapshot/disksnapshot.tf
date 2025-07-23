resource "azurerm_snapshot" "disksnapshot" {
  name                = var.snapshot_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  create_option       = var.create_option
  source_uri          = var.source_uri
}
