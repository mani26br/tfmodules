output "sg_id" {
  description = "Security group id"
  value = aws_security_group.sg.id
}

output "sg_arn" {
  description = "Security group arn"
  value = aws_security_group.sg.arn
}

output "assign_vpc_id" {
  description = "vpc id of security group which assigned to"
  value = aws_security_group.sg.vpc_id
}

output "sg_owner_id" {
  description = "Security group owner id"
  value = aws_security_group.sg.owner_id
}

output "sg_name" {
  description = "Security group name"
  value = aws_security_group.sg.name
}

output "sg_ingress" {
  description = "Security group's ingress"
  value = aws_security_group.sg.*.ingress
}

output "sg_egress" {
  description = "Security group's egress"
  value = aws_security_group.sg.*.egress
}
