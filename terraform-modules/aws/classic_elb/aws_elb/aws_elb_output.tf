output "elb_id" {
  value = aws_elb.elb.id
}

output "elb_arn" {
  value = aws_elb.elb.arn
}

output "elb_name" {
  value = aws_elb.elb.name
}

output "elb_dns_name" {
  value = aws_elb.elb.dns_name
}

output "elb_instances" {
  value = aws_elb.elb.instances
}

output "elb_source_security_group" {
  value = aws_elb.elb.source_security_group
}

output "elb_source_security_group_id" {
  value = aws_elb.elb.source_security_group_id
}

output "elb_zone_id" {
  value = aws_elb.elb.zone_id
}
