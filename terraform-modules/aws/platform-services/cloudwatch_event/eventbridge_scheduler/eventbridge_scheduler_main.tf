resource "aws_scheduler_schedule" "schedule" {
  name       = var.eventbridge_scheduler_name
  group_name = var.eventbridge_scheduler_group_name

  # Dynamic block for flexible_time_window when OFF
  dynamic "flexible_time_window" {
    for_each = var.flexible_time_window_mode == "OFF" ? [1] : []
    content {
      mode = var.flexible_time_window_mode
    }
  }

  # Dynamic block for flexible_time_window when ON
  dynamic "flexible_time_window" {
    for_each = var.flexible_time_window_mode == "FLEXIBLE" ? [1] : []
    content {
      mode = var.flexible_time_window_mode
      maximum_window_in_minutes = var.flexible_maximum_window_in_minutes
    }
  }

  schedule_expression_timezone = var.eventbridge_scheduler_timezone
  schedule_expression = var.eventbridge_scheduler_expression

  target {
    arn      = var.eventbridge_scheduler_target_arn
    role_arn = var.eventbridge_scheduler_role_arn
  }
}