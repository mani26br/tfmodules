resource "aws_ec2_instance_connect_endpoint" "endpoint" {
  subnet_id = var.ec2_instance_connect_subnet_id
  security_group_ids = var.ec2_instance_connect_security_group_id
  preserve_client_ip = var.ec2_instance_connect_preserve_client_ip
  tags = merge(tomap({
  "Name" = var.ec2_instance_connect_name,
}), var.ec2_instance_connect_tags)
}
