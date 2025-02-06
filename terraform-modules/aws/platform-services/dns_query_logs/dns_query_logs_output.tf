output dns_cloudwatch_log_group_arn {
  value       = aws_cloudwatch_log_group.query_logs.arn
  description = "The arn of the cloudwatch log group"
}

output dns_cloudwatch_log_group_name {
  value       = aws_cloudwatch_log_group.query_logs.name
  description = "The name of the cloudwatch log group"
}