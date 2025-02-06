#Manages a LoadBalancer Probe Resource.
resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id           = var.lb_probe_loadbalancer_id
  name                      = var.lb_probe_name
  port                      = var.lb_probe_port
}