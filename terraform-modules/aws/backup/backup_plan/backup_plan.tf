resource "aws_backup_plan" "backup_plan" {
  name = var.backup_plan_name

  dynamic "rule" {
    for_each = var.backup_plan_rule

    content {
      rule_name = lookup(rule.value, "rule_name", null)
      target_vault_name = lookup(rule.value, "target_vault_name", null)
      schedule = lookup(rule.value, "schedule", null)
      schedule_expression_timezone = lookup(rule.value, "schedule_expression_timezone", null)
      start_window = lookup(rule.value, "start_window", null)
      completion_window = lookup(rule.value, "completion_window", null)

      dynamic "lifecycle" {
        for_each = lookup(rule.value, "lifecycle", {})

        content {
          cold_storage_after = lookup(lifecycle.value, "cold_storage_after", null)
          delete_after = lookup(lifecycle.value, "delete_after", null)
        }
      }

      recovery_point_tags = lookup(rule.value, "recovery_point_tags", null)

      dynamic "copy_action" {
        for_each = lookup(rule.value, "copy_action", {})

        content {
          destination_vault_arn = lookup(copy_action.value, "destination_vault_arn", null)

          dynamic lifecycle {
            for_each = lookup(copy_action.value, "lifecycle", {})
            content {
              cold_storage_after = lookup(lifecycle.value, "cold_storage_after", null)
              delete_after = lookup(lifecycle.value, "delete_after", null)
            }
          }
        }
      }
    }
  }

  tags = merge(tomap({
  "Name"=var.backup_plan_name,
  }), var.backup_plan_tags)
}
