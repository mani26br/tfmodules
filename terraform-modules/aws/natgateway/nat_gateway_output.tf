output "natgateway_id" {
  value = aws_nat_gateway.natgateway.id
}

output "natgateway_allocation_id" {
  value = aws_nat_gateway.natgateway.allocation_id
}

output "natgateway_subnet_id" {
  value = aws_nat_gateway.natgateway.subnet_id
}

output "natgateway_network_interface_id" {
  value = aws_nat_gateway.natgateway.network_interface_id
}

output "natgateway_private_ip" {
  value = aws_nat_gateway.natgateway.private_ip
}

output "natgateway_public_ip" {
  value = aws_nat_gateway.natgateway.public_ip
}
