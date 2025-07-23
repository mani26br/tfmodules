resource "aws_network_acl" "network_acl" {
  vpc_id = "${var.network_acl_vpc_id}"
  subnet_ids = "${var.network_acl_subnet_ids}"

  dynamic "egress" {
    for_each = "${var.network_acl_egress}"

    content {
      from_port = "${lookup(egress.value, "from_port", null)}"
      to_port = "${lookup(egress.value, "to_port", null)}"
      rule_no = "${lookup(egress.value, "rule_no", null)}"
      action = "${lookup(egress.value, "action", null)}"
      protocol = "${lookup(egress.value, "protocol", null)}"
      cidr_block = "${lookup(egress.value, "cidr_block", null)}"
      ipv6_cidr_block = "${lookup(egress.value, "ipv6_cidr_block", null)}"
      icmp_type = "${lookup(egress.value, "icmp_type", null)}"
      icmp_code = "${lookup(egress.value, "icmp_code", null)}"
    }
  }

  dynamic "ingress" {
    for_each = "${var.network_acl_ingress}"

    content {
      from_port = "${lookup(ingress.value, "from_port", null)}"
      to_port = "${lookup(ingress.value, "to_port", null)}"
      rule_no = "${lookup(ingress.value, "rule_no", null)}"
      action = "${lookup(ingress.value, "action", null)}"
      protocol = "${lookup(ingress.value, "protocol", null)}"
      cidr_block = "${lookup(ingress.value, "cidr_block", null)}"
      ipv6_cidr_block = "${lookup(ingress.value, "ipv6_cidr_block", null)}"
      icmp_type = "${lookup(ingress.value, "icmp_type", null)}"
      icmp_code = "${lookup(ingress.value, "icmp_code", null)}"
    }
  }

  tags = "${merge(map(
    "Name", "${var.network_acl_name}",
    "vpc_id", "${var.network_acl_vpc_id}",
    ), var.network_acl_tags)}"
}
