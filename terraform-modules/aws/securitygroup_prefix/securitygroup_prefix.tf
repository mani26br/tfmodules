resource "aws_ec2_managed_prefix_list" "cidrrange" {
  name           = "NIH Prefix List"
  address_family = "IPv4"
  max_entries    = 20

  dynamic "entry" {
    for_each    = toset(var.NIH_networks)
    content {
      cidr = entry.value.cidr_block
      description = entry.value.description
    }
  }
}