resource "aws_security_group" "sg" {
  name = "${var.sg_name}"
  name_prefix = "${var.sg_name_prefix}"
  description = "${var.sg_description}"
  vpc_id = "${var.assign_vpc_id}"

  dynamic "ingress" {
    for_each = "${var.sg_ingress}"
    content {
      ipv6_cidr_blocks = "${lookup(ingress.value, "ipv6_cidr_blocks", null)}"
      prefix_list_ids = "${lookup(ingress.value, "prefix_list_ids", null)}"
      security_groups = "${lookup(ingress.value, "security_groups", null)}"
      self = "${lookup(ingress.value, "self", null)}"
      description = "${lookup(ingress.value, "description", null)}"
      from_port = "${lookup(ingress.value, "from_port", null)}"
      to_port = "${lookup(ingress.value, "to_port", null)}"
      protocol = "${lookup(ingress.value, "protocol", null)}"
      cidr_blocks = "${lookup(ingress.value, "cidr_blocks", null)}"
    }

  }

  dynamic "egress" {
    for_each = "${var.sg_egress}"
    content {
      from_port = "${lookup(egress.value, "from_port", null)}"
      to_port = "${lookup(egress.value, "to_port", null)}"
      protocol = "${lookup(egress.value, "protocol", null)}"
      cidr_blocks = "${lookup(egress.value, "cidr_blocks", null)}"
      ipv6_cidr_blocks = "${lookup(egress.value, "ipv6_cidr_blocks", null)}"
      security_groups = "${lookup(egress.value, "security_groups", null)}"
      self = "${lookup(egress.value, "self", null)}"
      description = "${lookup(egress.value, "description", null)}"
      prefix_list_ids = "${lookup(egress.value, "prefix_list_ids", null)}"
    }
  }

  tags = "${merge(tomap({
    "Name"=var.sg_name,
    "vpc_id"=var.assign_vpc_id,
    }), var.sg_tags)}"
}