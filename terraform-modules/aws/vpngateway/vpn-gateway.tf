resource "aws_vpn_gateway" "vpn_gateway" {
  vpc_id = "${var.assign_vpc_id}"
  tags = "${merge(map(
    "Name", "${var.vpn_gateway_name}",
    "vpc_id", "${var.assign_vpc_id}",
    ), var.vpn_gateway_tags)}"
}
