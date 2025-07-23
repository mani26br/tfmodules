output "backup_vault_id" {
  value = aws_backup_vault.backup_vault.id
}

output "backup_vault_arn" {
  value = aws_backup_vault.backup_vault.arn
}

output "backup_vault_recovery_points" {
  value = aws_backup_vault.backup_vault.recovery_points
}
