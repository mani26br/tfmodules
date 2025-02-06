resource "aws_cloudwatch_log_metric_filter" "metric_filter" {
  for_each = toset(var.log_group_name)

  name           = var.name
  pattern        = var.pattern
  log_group_name = "${each.value}"

  metric_transformation {
    name          = var.metric_transformation_name
    namespace     = var.metric_transformation_namespace
    value         = var.metric_transformation_value
    default_value = var.metric_transformation_default_value
  }
}