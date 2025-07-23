resource "aws_vpn_connection_route" "azure_local_route" {
  destination_cidr_block = "${var.client_local_cidr}"
  vpn_connection_id      = "${var.vpn_connection_id}"
}