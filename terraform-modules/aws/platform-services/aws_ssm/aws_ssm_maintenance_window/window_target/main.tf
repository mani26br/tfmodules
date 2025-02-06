resource "aws_ssm_maintenance_window_target" "target" {
  window_id     = var.window_id
  name          = var.name 
  description   = var.description
  resource_type = var.resource_type
  #note cannot use InstanceIds with *
    targets {
    key    = var.key
    values = var.values
  }
}