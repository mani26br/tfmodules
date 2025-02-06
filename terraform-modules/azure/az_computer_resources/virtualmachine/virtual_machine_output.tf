output "virtual_machine_id" {
  description = "Virtual Machine id"
  value = azurerm_virtual_machine.virtual_machine.id
}

output "virtual_machine_managed_identity" {
  description = "Virtual Machine id"
  value = "${ join("", azurerm_virtual_machine.virtual_machine.identity.*.principal_id) }"
}
