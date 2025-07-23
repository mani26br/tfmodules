resource "aws_cloudwatch_log_group" "query_logs" {
  name = "/aws/route53/${data.aws_caller_identity.current.id}/${var.environment}/query_logs/${var.zone_id}/${var.query_logs}"
  retention_in_days = var.retention_period
  tags   = merge(tomap({
  "Name" = "/aws/route53/${data.aws_caller_identity.current.id}/${var.environment}/query_logs/${var.zone_id}/${var.query_logs}",
  }), var.cloudwatch_log_tags)
}

resource "aws_cloudwatch_log_resource_policy" "route53-query-logging-policy" {
  policy_document = data.aws_iam_policy_document.route53-query-logging-policy.json
  policy_name = "route53-query-logging-policy"
}

resource "aws_route53_query_log" "query_logs_com" {
  depends_on = [aws_cloudwatch_log_resource_policy.route53-query-logging-policy,aws_cloudwatch_log_group.query_logs]
  cloudwatch_log_group_arn = aws_cloudwatch_log_group.query_logs.arn
  zone_id = var.zone_id
}
