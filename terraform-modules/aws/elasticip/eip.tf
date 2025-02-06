resource "aws_eip" "eip" {
  vpc = var.eip_to_vpc
  instance = var.eip_to_instance
  network_interface = var.eip_network_interface
  associate_with_private_ip = var.eip_associate_with_private_ip
  tags = merge(map(
    "Name", var.eip_name,
    "instance", var.eip_to_instance,
    "vpc", var.eip_to_vpc,
    ), var.eip_tags)

  public_ipv4_pool = var.eip_public_ipv4_pool
}
