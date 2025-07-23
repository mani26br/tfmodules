output "eip_id" {
  description = "Elastic Ip id"
  value = aws_eip.eip.id
}

output "eip_private_ip" {
  description = "Elastic Ip private ip"
  value = aws_eip.eip.private_ip
}

output "eip_private_dns" {
  description = "Elastic Ip private dns"
  value = aws_eip.eip.private_dns
}

output "eip_associate_with_private_ip" {
  description = "Elastic Ip associate with private ip"
  value = aws_eip.eip.associate_with_private_ip
}

output "eip_public_ip" {
  description = "Elastic Ip public ip"
  value = aws_eip.eip.public_ip
}

output "eip_public_dns" {
  description = "Elastic Ip public dns"
  value = aws_eip.eip.public_dns
}

output "eip_instance" {
  description = "Elastic Ip instance"
  value = aws_eip.eip.instance
}

output "eip_network_interface" {
  description = "Elastic Ip network interface"
  value = aws_eip.eip.network_interface
}

output "eip_public_ipv4_pool" {
  description = "Elastic Ip public ipv4 pool"
  value = aws_eip.eip.public_ipv4_pool
}
