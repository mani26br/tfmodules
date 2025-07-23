resource "aws_ssm_maintenance_window_task" "example" {
  name = var.name
  max_concurrency = 1
  max_errors      = 1
  priority        = var.priority
  task_arn        = var.task_arn
  task_type       = var.task_type
  window_id       = var.window_id

  #note can only use InstanceIds or WindowTargetIds, WindowTargetIds works better
  targets {
    key    = var.window_target_key
    values = var.window_target_ids_values
  }
 
  task_invocation_parameters {
    run_command_parameters {
      
    output_s3_bucket     = var.output_s3_bucket
    output_s3_key_prefix = var.output_s3_key_prefix
    service_role_arn     = var.service_role_arn
    timeout_seconds      = 600

    # notification_config {
    #   notification_arn    = var.notification_arn
    #   notification_events = ["All"]
    #   notification_type   = "Command"
    # }
    
    dynamic "parameter" {
      for_each = var.parameter
      content {
        name   = parameter.key
        values = ["${parameter.value}"]
      }
    }
    }
  }
}
