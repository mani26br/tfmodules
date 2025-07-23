resource "aws_network_interface" "network_interface" {
  subnet_id       = var.subnet_id
  private_ips     = var.private_ips
  security_groups = var.security_groups
  tags = merge(map(
      "Name", var.network_interface_name,
      ), var.network_interface_tags)
}
