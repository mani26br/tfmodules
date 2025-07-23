output "cloudwatch_event_arn" {
 value = aws_cloudwatch_event_target.target.arn 
}

output "cloudwatch_event_rule_arn" {
  value = aws_cloudwatch_event_rule.rule.arn
}