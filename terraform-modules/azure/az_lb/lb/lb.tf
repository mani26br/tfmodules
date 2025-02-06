resource "azurerm_lb" "lb" {
  name = var.lb_name
  resource_group_name = var.lb_rg_name
  location = var.lb_rg_location

  dynamic "frontend_ip_configuration" {
    for_each = var.lb_frontend_ip_configuration

    content {
      name = lookup(frontend_ip_configuration.value, "name", null)
      #zones = lookup(frontend_ip_configuration.value, "zones", "")
      subnet_id = lookup(frontend_ip_configuration.value, "subnet_id", null)
      gateway_load_balancer_frontend_ip_configuration_id = lookup(frontend_ip_configuration.value, "gateway_load_balancer_frontend_ip_configuration_id", null)
      private_ip_address = lookup(frontend_ip_configuration.value, "private_ip_address", null)
      private_ip_address_allocation = lookup(frontend_ip_configuration.value, "private_ip_address_allocation", null)
      private_ip_address_version = lookup(frontend_ip_configuration.value, "private_ip_address_version", null)
      public_ip_address_id = lookup(frontend_ip_configuration.value, "public_ip_address_id", null)
      public_ip_prefix_id = lookup(frontend_ip_configuration.value, "public_ip_prefix_id", null)
    }
  }

  sku = var.lb_sku
  sku_tier = var.lb_sku_tier
  tags = var.lb_tags
}
