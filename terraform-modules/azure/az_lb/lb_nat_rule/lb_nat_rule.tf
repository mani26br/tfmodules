resource "azurerm_lb_nat_rule" "lb_nat_rule" {
  name = var.lb_nat_rule_name
  resource_group_name = var.lb_nat_rule_rg_name
  loadbalancer_id = var.lb_nat_rule_loadbalancer_id
  frontend_ip_configuration_name = var.lb_nat_rule_frontend_ip_config_name
  protocol = var.lb_nat_rule_protocol
  frontend_port = var.lb_nat_rule_frontend_port
  backend_port = var.lb_nat_rule_backend_port
  idle_timeout_in_minutes = var.lb_nat_rule_idle_timeout_in_minutes
  enable_floating_ip = var.lb_nat_rule_enable_floating_ip
  enable_tcp_reset = var.lb_nat_rule_enable_tcp_reset
}
