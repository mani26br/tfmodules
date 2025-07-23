output vpc_flowlog_id {
  value       = aws_flow_log.vpc_flow_log.id
  description = "The ID of the Flow Log resource"
}

output "vpc_flowloggroup_name" {
  value = aws_cloudwatch_log_group.vpc_flow_log_group.name
  description = "name of the vpc flow logs log group"
}
