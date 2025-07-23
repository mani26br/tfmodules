resource "aws_nat_gateway" "natgateway" {
  allocation_id = var.natgateway_allocation_id
  subnet_id = var.natgateway_subnet_id
  tags = merge(map(
    "Name", var.natgateway_name,
    "allocation_id", var.natgateway_allocation_id,
    ), var.natgateway_tags)
}
