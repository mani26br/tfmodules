output "maintenance_window_target_id" {
  description = "The ID of the created AWS SSM Maintenance Window Target."
  value       = aws_ssm_maintenance_window_target.target.id
}