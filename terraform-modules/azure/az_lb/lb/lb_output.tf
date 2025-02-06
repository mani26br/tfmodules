output "lb_id" {
  value = azurerm_lb.lb.id
}

output "lb_frontend_ip_configuration" {
  value = azurerm_lb.lb.frontend_ip_configuration
}

output "lb_private_ip_address" {
  value = azurerm_lb.lb.private_ip_address
}

output "lb_private_ip_addresses" {
  value = azurerm_lb.lb.private_ip_addresses
}
