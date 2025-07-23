resource "aws_subnet" "subnet" {
  cidr_block = "${var.subnet_cidr_block}"
  map_public_ip_on_launch = "${var.subnet_public_ip_on_launch}"
  availability_zone = "${var.subnet_az}"
  vpc_id = "${var.subnet_associate_vpc_id}"
  tags = "${merge(map(
    "Name", "${var.subnet_name}",
    "vpc_id", "${var.subnet_associate_vpc_id}"
    ), var.subnet_tags)
  }"
}
