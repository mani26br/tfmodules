#The ID of the Load Balancer Probe.
output "lb_probe_id" {
  value = azurerm_lb_probe.lb_probe.id
}