resource "aws_route_table" "vpn_routetable" {
  vpc_id = var.assign_vpc_id
  
  route {
    cidr_block = var.cidr_block
    gateway_id = var.gateway_id
  }
  
  tags = merge(map(
    "name", var.vpn_routetable_name,
    ),var.vpn_routetable_tags)
}
