output "maintenance_window_id" {
  description = "The ID of the created AWS SSM Maintenance Window."
  value       = aws_ssm_maintenance_window.example.id
}

