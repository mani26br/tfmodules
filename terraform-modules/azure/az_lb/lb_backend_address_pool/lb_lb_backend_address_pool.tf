resource "azurerm_lb_backend_address_pool" "lb_backend_address_pool" {
  name = var.lb_backend_address_pool_name
  loadbalancer_id = var.lb_backend_address_pool_lb_id

/*
  dynamic "tunnel_interface" {
    for_each = var.lb_backend_address_pool_tunnel_interface

    content {
      identifier = lookup(tunnel_interface.value, "identifier", null)
      type = lookup(tunnel_interface.value, "type", null)
      protocol = lookup(tunnel_interface.value, "protocol", null)
      port = lookup(tunnel_interface.value, "port", null)
    }
  }
*/
}
