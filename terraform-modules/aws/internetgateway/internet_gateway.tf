resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${var.internet_gateway_vpc_id}"
  tags = "${merge(map(
    "Name", "${var.internet_gateway_name}",
    "vpc_id", "${var.internet_gateway_vpc_id}",
    ), var.internet_gateway_tags)}"
}
