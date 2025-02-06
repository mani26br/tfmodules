output "backup_plan_id" {
  value = aws_backup_plan.backup_plan.id
}

output "backup_plan_arn" {
  value = aws_backup_plan.backup_plan.arn
}

output "backup_plan_version" {
  value = aws_backup_plan.backup_plan.version
}
