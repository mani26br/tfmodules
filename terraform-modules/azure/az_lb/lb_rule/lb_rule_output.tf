# The ID of the Load Balancer Rule.
output "lb_rule_id" {
  value = azurerm_lb_rule.lb_rule.id
}