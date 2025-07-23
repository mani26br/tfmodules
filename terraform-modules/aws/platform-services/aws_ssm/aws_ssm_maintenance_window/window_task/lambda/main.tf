resource "aws_ssm_maintenance_window_task" "example" {
  name = var.name
  max_concurrency = var.create_targets ? var.max_concurrency : null
  max_errors = var.create_targets ? var.max_errors : null
  service_role_arn = var.service_role_arn
  priority        = var.priority
  task_arn        = var.task_arn
  task_type       = var.task_type
  window_id       = var.window_id

  #note can only use InstanceIds or WindowTargetIds, WindowTargetIds works better
  dynamic "targets" {
    for_each = var.create_targets ? [1] : []
    content {
      key    = var.window_target_key
      values = var.window_target_ids_values
    }
  }
    
  task_invocation_parameters {
    lambda_parameters {
      client_context = var.client_context #base64encode("{\"key1\":\"value1\"}")
      payload        = var.payload #"{\"key1\":\"value1\"}"
    }
  }
}
