resource "azurerm_logic_app_workflow" "logic_app_workflow" {
  name                = var.logic_app_workflow_name
  location            = var.logicapp_location
  resource_group_name = var.resource_group_name
  lifecycle {
    ignore_changes = ["parameters"]
  }
}