resource "aws_ssm_maintenance_window" "example" {
  name     = var.name
  schedule = var.schedule
  duration = var.duration
  cutoff   = var.cutoff
  schedule_timezone = var.schedule_timezone
  tags        = merge(tomap({
  "Name" = var.name,
  }), var.tags)
}