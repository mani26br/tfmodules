resource "azurerm_backup_policy_file_share" "backup_policy_file_share" {
  name = var.backup_policy_file_share_name
  resource_group_name = var.backup_policy_file_share_resource_group_name
  recovery_vault_name = var.backup_policy_file_share_recovery_vault_name

  dynamic "backup" {
    for_each = var.backup_policy_file_share_backup

    content {
      frequency = lookup(backup.value, "frequency", "")
      time = lookup(backup.value, "time", "")
    }
  }

  timezone = var.backup_policy_file_share_timezone

  dynamic "retention_daily" {
    for_each = var.backup_policy_file_share_retention_daily

    content {
      count = lookup(retention_daily.value, "count", "")
    }
  }

  dynamic "retention_weekly" {
    for_each = var.backup_policy_file_share_retention_weekly

    content {
      count = lookup(retention_weekly.value, "count", "")
      weekdays = lookup(retention_weekly.value, "weekdays", "")
    }
  }

  dynamic "retention_monthly" {
    for_each = var.backup_policy_file_share_retention_monthly

    content {
      count = lookup(retention_monthly.value, "count", "")
      weekdays = lookup(retention_monthly.value, "weekdays", "")
      weeks = lookup(retention_monthly.value, "weeks", "")
    }
  }

  dynamic "retention_yearly" {
    for_each = var.backup_policy_file_share_retention_yearly

    content {
      count = lookup(retention_yearly.value, "count", "")
      weekdays = lookup(retention_yearly.value, "weekdays", "")
      weeks = lookup(retention_yearly.value, "weeks", "")
      months = lookup(retention_yearly.value, "months", "")
    }
  }

}
