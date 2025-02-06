output "public_ip_id" {
  description = "public ip id"
  value = azurerm_public_ip.public_ip.id
}

output "public_ip_name" {
  description = "public ip name"
  value = azurerm_public_ip.public_ip.name
}

output "public_ip_ip_address" {
  description = "public ip address"
  value = azurerm_public_ip.public_ip.ip_address
}

output "public_ip_fqdn" {
  description = "public ip fqdn"
  value = azurerm_public_ip.public_ip.fqdn
}
