resource "azurerm_logic_app_action_http" "logic_app_action_http" {
  name         = var.app_name
  logic_app_id = var.logic_app_id
  method       = var.method
  uri          = var.uri
}
