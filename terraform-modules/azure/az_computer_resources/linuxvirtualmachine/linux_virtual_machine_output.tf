output "linux_virtual_machine-id" {
  description = "Linux Virtual Machine's ID"
  value = azurerm_linux_virtual_machine.linux_virtual_machine.id
}

output "linux_virtual_machine-identity" {
  description = "Linux Virtual Machine's Identity"
  value = azurerm_linux_virtual_machine.linux_virtual_machine.identity
}

output "linux_virtual_machine-private_ip_address" {
  description = "Linux Virtual Machine's Private IP Address"
  value = azurerm_linux_virtual_machine.linux_virtual_machine.private_ip_address
}

output "linux_virtual_machine-private_ip_addresses" {
  description = "Linux Virtual Machine's Private IP Addresses"
  value = azurerm_linux_virtual_machine.linux_virtual_machine.private_ip_addresses
}

output "linux_virtual_machine-public_ip_address" {
  description = "Linux Virtual Machine's Public IP Address"
  value = azurerm_linux_virtual_machine.linux_virtual_machine.public_ip_address
}

output "linux_virtual_machine-public_ip_addresses" {
  description = "Linux Virtual Machine's Public IP Addresses"
  value = azurerm_linux_virtual_machine.linux_virtual_machine.public_ip_addresses
}

output "linux_virtual_machine-virtual_machine_id" {
  description = "Linux Virtual Machine's Unique Virtual Machine ID"
  value = azurerm_linux_virtual_machine.linux_virtual_machine.virtual_machine_id
}
