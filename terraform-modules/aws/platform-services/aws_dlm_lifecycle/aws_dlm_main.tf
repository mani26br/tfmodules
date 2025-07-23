resource "aws_dlm_lifecycle_policy" "this" {
  description        = var.description
  execution_role_arn = var.execution_role_arn
  state              = var.state

  policy_details {
    resource_types = var.resource_types

  dynamic "schedule" {
    for_each = var.schedules
    content {
      name = schedule.key

      create_rule {
        interval      = schedule.value.create_rule.interval
        interval_unit = schedule.value.create_rule.interval_unit
        times         = schedule.value.create_rule.times
      }

      retain_rule {
        count = schedule.value.retain_rule.count
      }

      tags_to_add = schedule.value.tags_to_add
      copy_tags   = schedule.value.copy_tags
    }
  }

    target_tags = var.target_tags
  }
  tags = merge(tomap({
  "Name" = var.dlm_policy_name,
  }), var.dlm_tags)
}
