resource "azurerm_dev_test_global_vm_shutdown_schedule" "example" {
  virtual_machine_id = var.virtual_machine_id
  location           = var.location
  enabled            = var.enabled

  daily_recurrence_time = var.daily_recurrence_time
  timezone              = var.timezone

  dynamic "notification_settings" {
     for_each = "${var.shutdown_notifications}"

	 content {
       enabled         = var.notifications_enabled
       time_in_minutes = var.time_in_minutes
       webhook_url     = var.webhook_url
    }
}

  lifecycle {
    ignore_changes = [
       notification_settings,
    ]
  }

}
