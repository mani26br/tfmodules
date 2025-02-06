resource "aws_vpc_endpoint" "aws_transfer_server" {
  service_name = var.transfer_server_name
  vpc_id = var.transfer_vpc_id
  auto_accept = var.transfer_auto_accept
  policy = var.transfer_policy
  private_dns_enabled = var.transfer_private_dns_enable
  route_table_ids = var.transfer_route_table_ids
  subnet_ids = var.transfer_subnet_ids
  security_group_ids = var.transfer_security_group_ids
  tags = var.transfer_tags
  vpc_endpoint_type = var.transfer_vpc_endpoint_type
}
