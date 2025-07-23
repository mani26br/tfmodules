output waf_cloudwatch_log_group_arn {
  value       = aws_cloudwatch_log_group.wafV2_cloudwatch_logs.arn
  description = "The arn of the cloudwatch log group"
}

output waf_cloudwatch_log_group_name {
  value       = aws_cloudwatch_log_group.wafV2_cloudwatch_logs.name
  description = "The name of the cloudwatch log group"
}

output "WafV2_acl_arns" {
  value = [for acl in aws_wafv2_web_acl.wafV2_logs : acl.arn]
  description = "The Arns of all WAF-ACL instances"
}
