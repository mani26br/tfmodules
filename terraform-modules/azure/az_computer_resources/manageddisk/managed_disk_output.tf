output "managed_disk_id" {
  description = "managed disk Id"
  value = azurerm_managed_disk.managed_disk.id
}

output "managed_disk_name" {
  description = "managed disk Name"
  value = azurerm_managed_disk.managed_disk.name
}
