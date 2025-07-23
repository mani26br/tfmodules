resource "azurerm_lb_backend_address_pool_address" "lb_backend_address_pool_address" {
  backend_address_pool_id = var.lb_backend_address_pool_address_id
  ip_address = var.lb_backend_address_pool_address_ip_address
  name = var.lb_backend_address_pool_address_name
  virtual_network_id = var.lb_backend_address_pool_address_vnet_id
}
