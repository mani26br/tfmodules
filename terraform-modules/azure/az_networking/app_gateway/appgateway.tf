resource "azurerm_application_gateway" "network" {
  name                = var.app_gateway_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  
  dynamic "sku" {
    for_each = var.sku

    content {
      name = "${lookup(sku.value, "name", null)}"
      tier = "${lookup(sku.value, "tier", null)}"
      capacity = "${lookup(sku.value, "capacity", null)}"
    }
  }
  
  dynamic "gateway_ip_configuration" {
    for_each = var.gateway_ip_configuration

    content {
     name = "${lookup(gateway_ip_configuration.value, "name", null)}"
     subnet_id = "${lookup(gateway_ip_configuration.value, "subnet_id", null)}"
    }
  }
  
  dynamic "frontend_port" {
    for_each = var.frontend_port

    content {
     name = "${lookup(frontend_port.value, "name", null)}"
     port = "${lookup(frontend_port.value, "port", null)}"
    }
  }
  
  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_configuration

    content {
     name = "${lookup(frontend_ip_configuration.value, "name", null)}"
     public_ip_address_id = "${lookup(frontend_ip_configuration.value, "public_ip_address_id", null)}"
    }
  }
  
  dynamic "backend_address_pool" {
    for_each = var.backend_address_pool

    content {
     name = "${lookup(backend_address_pool.value, "name", null)}"
    }
  }
  
  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings

    content {
     name = "${lookup(backend_http_settings.value, "name", null)}"
     cookie_based_affinity = "${lookup(backend_http_settings.value, "cookie_based_affinity", null)}"
     path = "${lookup(backend_http_settings.value, "path", null)}"
     port = "${lookup(backend_http_settings.value, "port", null)}"
     protocol = "${lookup(backend_http_settings.value, "protocol", null)}"
     request_timeout = "${lookup(backend_http_settings.value, "request_timeout", null)}"
    }
  }
  
  dynamic "http_listener" {
    for_each = var.http_listener

    content {
     name = "${lookup(http_listener.value, "name", null)}"
     frontend_ip_configuration_name = "${lookup(http_listener.value, "frontend_ip_configuration_name", null)}"
     frontend_port_name = "${lookup(http_listener.value, "frontend_port_name", null)}"
     protocol = "${lookup(http_listener.value, "protocol", null)}"
    }
  }
  
  dynamic "request_routing_rule" {
    for_each = var.request_routing_rule

    content {
     name = "${lookup(request_routing_rule.value, "name", null)}"
     rule_type = "${lookup(request_routing_rule.value, "rule_type", null)}"
     http_listener_name = "${lookup(request_routing_rule.value, "http_listener_name", null)}"
     backend_address_pool_name = "${lookup(request_routing_rule.value, "backend_address_pool_name", null)}"
     backend_http_settings_name = "${lookup(request_routing_rule.value, "backend_http_settings_name", null)}"
    }
  }
}
