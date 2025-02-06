resource "aws_route" "route" {
  route_table_id = "${var.route_route_table_id}"
  destination_cidr_block = "${var.route_destination_cidr_block}"
  destination_ipv6_cidr_block = "${var.route_destination_ipv6_cidr_block}"
  egress_only_gateway_id = "${var.route_egress_only_gateway_id}"
  gateway_id = "${var.route_gateway_id}"
  instance_id = "${var.route_instance_id}"
  nat_gateway_id = "${var.route_nat_gateway_id}"
  network_interface_id = "${var.route_network_interface_id}"
  transit_gateway_id = "${var.route_transit_gateway_id}"
  vpc_peering_connection_id = "${var.route_vpc_peering_connection_id}"
}
