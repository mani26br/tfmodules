resource "azurerm_monitor_diagnostic_setting" "diagnostic_settings" {
  name                           = var.diagnostic_setting_name
  target_resource_id             = var.target_resource_id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = var.log_analytics_destination_type
  storage_account_id = var.storage_account_id

  dynamic "log" {
    for_each = var.diagnostic_logs

    content {
      category = lookup(log.value, "category", null)
      enabled  = lookup(log.value, "enabled", true)

	  retention_policy {
        enabled = lookup(log.value, "enabled", false)
        days = lookup(log.value, "days", null)
      }
    }
 }

  dynamic "metric" {
    for_each = var.diagnostic_metrics

    content {
      category = lookup(metric.value, "category", null)
      enabled  = lookup(metric.value, "enabled", true)

	  retention_policy {
        enabled = lookup(metric.value, "enabled", false)
        days = lookup(metric.value, "days", null)
      }
    }
  }
}
