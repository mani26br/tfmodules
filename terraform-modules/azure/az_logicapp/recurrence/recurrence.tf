resource "azurerm_logic_app_trigger_recurrence" "logic_app_trigger_recurrence" {
  name         = var.logicapp_trigger_name
  logic_app_id = var.logic_app_action_http_action
  frequency    = var.frequency
  interval     = var.interval
  #start_time   = var.start_time
  time_zone    = var.time_zone
  dynamic "schedule" {
    for_each = "${var.schedule_job}"

    content {
      at_these_minutes = "${lookup(schedule.value, "at_these_minutes ", null)}"
      at_these_hours = "${lookup(schedule.value, "at_these_hours", null)}"
      on_these_days = "${lookup(schedule.value, "on_these_days", null)}"
    }
  }
}