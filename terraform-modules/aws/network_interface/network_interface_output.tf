output "network_interface_id" {
  description = "network interface id"
  value = aws_network_interface.network_interface.id
}

output "network_interface_subnet_id" {
  description = "network interface subnet id"
  value = aws_network_interface.network_interface.subnet_id
}

output "network_interface_private_ips" {
  description = "network interface private ips"
  value = aws_network_interface.network_interface.private_ips
}

output "network_interface_security_groups" {
  description = "network interface security groups"
  value = aws_network_interface.network_interface.security_groups
}
