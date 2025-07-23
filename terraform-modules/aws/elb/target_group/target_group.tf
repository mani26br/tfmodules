resource "aws_lb_target_group" "target_group" {
  name = var.target_group_name
  name_prefix = var.target_group_name_prefix
  port = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id = var.target_group_vpc_id
  deregistration_delay = var.target_group_deregistration_delay
  slow_start = var.target_group_slow_start
  load_balancing_algorithm_type = var.target_group_load_balancing_algorithm_type
  lambda_multi_value_headers_enabled = var.target_group_lambda_multi_value_headers_enabled
  proxy_protocol_v2 = var.target_group_proxy_protocol_v2

  dynamic "stickiness" {
    for_each = var.target_group_stickiness

    content {
      type = lookup(stickiness.value, "type", null)
      cookie_duration = lookup(stickiness.value, "cookie_duration", null)
      enabled = lookup(stickiness.value, "enabled", null)
    }
  }

  dynamic "health_check" {
    for_each = var.target_group_health_check

    content {
      enabled = lookup(health_check.value, "enabled", null)
      interval = lookup(health_check.value, "interval", null)
      path = lookup(health_check.value, "path", null)
      port = lookup(health_check.value, "port", null)
      protocol = lookup(health_check.value, "protocol", null)
      timeout = lookup(health_check.value, "timeout", null)
      healthy_threshold = lookup(health_check.value, "healthy_threshold", null)
      unhealthy_threshold = lookup(health_check.value, "unhealthy_threshold", null)
      matcher = lookup(health_check.value, "matcher", null)
    }
  }

  target_type = var.target_group_target_type
  tags = merge(tomap({
  "Name" = var.target_group_name,
  }), var.target_group_tags)
}
