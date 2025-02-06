output cloudtrail_cloudwatch_log_group_arn {
  value       = aws_cloudwatch_log_group.cloudtrail_logs.arn
  description = "The arn of the cloudwatch log group"
}

output cloudtrail_cloudwatch_log_group_name {
  value       = aws_cloudwatch_log_group.cloudtrail_logs.name
  description = "The name of the cloudwatch log group"
}