resource "azurerm_frontdoor" "frontdoor" {
  name                = var.frontdoor_name
  resource_group_name = var.resource_group_name
  enforce_backend_pools_certificate_name_check = var.enforce_backend_pools_certificate_name_check
  backend_pools_send_receive_timeout_seconds = var.backend_pools_send_receive_timeout_seconds
  
  dynamic "routing_rule" {
    for_each = var.forward_routing_rule 

    content {
      name = "${lookup(routing_rule.value, "name", null)}"
      accepted_protocols  = "${lookup(routing_rule.value, "accepted_protocols", null)}"
      patterns_to_match   = "${lookup(routing_rule.value, "patterns_to_match", null)}"
      frontend_endpoints  = "${lookup(routing_rule.value, "frontend_endpoints", null)}"
      dynamic "forwarding_configuration" {
        for_each = lookup(routing_rule.value, "forwarding_configuration", [])

        content {
           forwarding_protocol  = "${lookup(forwarding_configuration.value, "forwarding_protocol", null)}"
           backend_pool_name    = "${lookup(forwarding_configuration.value, "backend_pool_name", null)}"
        }
      }
    }
  }
  
  dynamic "routing_rule" {
    for_each = var.redirect_routing_rule 

    content {
      name = "${lookup(routing_rule.value, "name", null)}"
      accepted_protocols  = "${lookup(routing_rule.value, "accepted_protocols", null)}"
      patterns_to_match   = "${lookup(routing_rule.value, "patterns_to_match", null)}"
      frontend_endpoints  = "${lookup(routing_rule.value, "frontend_endpoints", null)}"
      dynamic "redirect_configuration" {
        for_each = lookup(routing_rule.value, "redirect_configuration", [])

        content {
           custom_host  = "${lookup(redirect_configuration.value, "custom_host", null)}"
           redirect_protocol    = "${lookup(redirect_configuration.value, "redirect_protocol", null)}"
           redirect_type     = "${lookup(redirect_configuration.value, "redirect_type", null)}"
           custom_fragment     = "${lookup(redirect_configuration.value, "custom_fragment", null)}"
           custom_path     = "${lookup(redirect_configuration.value, "custom_path", null)}"
           custom_query_string     = "${lookup(redirect_configuration.value, "custom_query_string", null)}"
        }
      }
    }
  }
  
  
  dynamic "backend_pool_load_balancing" {
    for_each = var.backend_pool_load_balancing 

    content {
     name = "${lookup(backend_pool_load_balancing.value, "name", null)}"
    }
  }
  
  dynamic "backend_pool_health_probe" {
    for_each = var.backend_pool_health_probe 

    content {
     name = "${lookup(backend_pool_health_probe.value, "name", null)}"
     enabled = "${lookup(backend_pool_health_probe.value, "enabled", null)}"
     path = "${lookup(backend_pool_health_probe.value, "path", null)}"
     protocol = "${lookup(backend_pool_health_probe.value, "protocol", null)}"
     probe_method = "${lookup(backend_pool_health_probe.value, "probe_method", null)}"
     interval_in_seconds = "${lookup(backend_pool_health_probe.value, "interval_in_seconds", null)}"
    }
  }
  
  dynamic "backend_pool" {
    for_each = var.app_backend_pool
  
    content {
      name  = "${lookup(backend_pool.value, "name", null)}"
      dynamic "backend" {
        for_each = lookup(backend_pool.value, "backend", [])
      
        content {
          host_header  = "${lookup(backend.value, "host_header", null)}"
          address      = "${lookup(backend.value, "address", null)}"
          http_port    = "${lookup(backend.value, "http_port", null)}"
          https_port   = "${lookup(backend.value, "https_port", null)}"
          enabled   = "${lookup(backend.value, "enabled", null)}"
          priority   = "${lookup(backend.value, "priority", null)}"
          weight    = "${lookup(backend.value, "weight", null)}"
        }
      }
      load_balancing_name      = "${lookup(backend_pool.value, "load_balancing_name", null)}"
      health_probe_name    = "${lookup(backend_pool.value, "health_probe_name", null)}"
    }
  }
  
  dynamic "frontend_endpoint" {
    for_each = var.frontend_endpoint 

    content {
     name = "${lookup(frontend_endpoint.value, "name", null)}"
     host_name  = "${lookup(frontend_endpoint.value, "host_name", null)}"
     session_affinity_enabled = "${lookup(frontend_endpoint.value, "session_affinity_enabled", null)}"
     web_application_firewall_policy_link_id = "${lookup(frontend_endpoint.value, "web_application_firewall_policy_link_id", null)}"
    }
  }
}