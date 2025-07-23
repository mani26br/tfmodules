output "arn" {
  value = aws_ec2_instance_connect_endpoint.endpoint.arn
}

output "availability_zone" {
  value = aws_ec2_instance_connect_endpoint.endpoint.availability_zone
}

output "dns_name" {
  value = aws_ec2_instance_connect_endpoint.endpoint.dns_name
}

output "fips_dns_name" {
  value = aws_ec2_instance_connect_endpoint.endpoint.fips_dns_name
}

output "network_interface_ids" {
  value = aws_ec2_instance_connect_endpoint.endpoint.network_interface_ids
}

output "owner_id" {
  value = aws_ec2_instance_connect_endpoint.endpoint.owner_id
}

output "tags_all" {
  value = aws_ec2_instance_connect_endpoint.endpoint.tags_all
}

output "vpc_id" {
  value = aws_ec2_instance_connect_endpoint.endpoint.vpc_id
}
