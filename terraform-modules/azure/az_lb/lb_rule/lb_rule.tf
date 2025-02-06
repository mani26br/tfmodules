#Manages a Load Balancer Rule.
resource "azurerm_lb_rule" "lb_rule" {
  name                           = var.lb_rule_name
  loadbalancer_id                = var.lb_rule_loadbalancer_id
  protocol                       = var.lb_rule_protocol
  frontend_port                  = var.lb_rule_frontend_port
  backend_port                   = var.lb_rule_backend_port
  frontend_ip_configuration_name = var.lb_rule_frontend_ip_config_name
  enable_floating_ip             = var.lb_rule_enable_floating_ip
  disable_outbound_snat          = var.lb_rule_disable_outbound_snat
  probe_id                       = var.lb_rule_probe_id
  backend_address_pool_ids       = var.lb_rule_backend_address_pool_ids
}