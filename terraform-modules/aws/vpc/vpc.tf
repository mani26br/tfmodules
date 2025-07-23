resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpccidr}"
  instance_tenancy = "${var.vpctenancy}"
  enable_dns_support = "${var.dnssupport}"
  enable_dns_hostnames = "${var.dnshostname}"
  assign_generated_ipv6_cidr_block = "${var.vpccidrblockipv6}"
  tags = "${merge(map(
    "Name", "${var.vpcname}",
    "cidr_block", "${var.vpccidr}",
    ), var.vpc_tags)}"
}
