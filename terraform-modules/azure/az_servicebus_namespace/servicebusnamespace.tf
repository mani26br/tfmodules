resource "azurerm_servicebus_namespace" "servicebus_namespace" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  
}