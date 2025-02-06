resource "aws_cloudwatch_event_rule" "rule" {
  name        = var.cloudwatch_event_rule_name
  description = var.cloudwatch_event_rule_description
  schedule_expression = var.cloudwatch_event_rule_schedule_expression 
}

resource "aws_cloudwatch_event_target" "target" {
  rule      = aws_cloudwatch_event_rule.rule.name
  target_id = var.cloudwatch_event_target_id
  arn       = var.cloudwatch_event_target_arn
}