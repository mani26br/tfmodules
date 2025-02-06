resource "azurerm_servicebus_queue" "servicebus_queue" {
  name                = var.servicebus_queue_name
  resource_group_name = var.resource_group_name
  namespace_name      = var.servicebus_namespace_name
  enable_partitioning = var.enable_partitioning
}
