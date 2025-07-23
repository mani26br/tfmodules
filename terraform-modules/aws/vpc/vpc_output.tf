output "vpc_arn" {
  description = "VPC ARN output"
  value = aws_vpc.vpc.arn
}

output "vpc_id" {
  description = "VPC ID"
  value = aws_vpc.vpc.id
}

output "vpc_cidrblock" {
  description = "VPC CIDR Range"
  value = aws_vpc.vpc.cidr_block
}

output "vpc_instance_tenancy" {
  description = "VPC Instance Tenancy"
  value = aws_vpc.vpc.instance_tenancy
}

output "vpc_enable_dns_support" {
  description = "VPC Enabled DNS Support"
  value = aws_vpc.vpc.enable_dns_support
}

output "vpc_main_route_table_id" {
  description = "VPC Main Route table id"
  value = aws_vpc.vpc.main_route_table_id
}

output "vpc_default_network_acl_id" {
  description = "VPC Default Network ACL ID"
  value = aws_vpc.vpc.default_network_acl_id
}

output "vpc_default_security_group_id" {
  description = "VPC Default Security Group ID"
  value = aws_vpc.vpc.default_security_group_id
}

output "vpc_default_route_table_id" {
  description = "VPC Default Route Table ID"
  value = aws_vpc.vpc.default_route_table_id
}

output "vpc_ipv6_association_id" {
  description = "VPC Default Association ID"
  value = aws_vpc.vpc.ipv6_association_id
}

output "vpc_ipv6_cidr_block" {
  description = "VPC Default ipv6 cidr block"
  value = aws_vpc.vpc.ipv6_cidr_block
}

output "vpc_owner_id" {
  description = "VPC Owner Id"
  value = aws_vpc.vpc.owner_id
}
