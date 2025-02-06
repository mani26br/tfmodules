output "secretsmanager_secret_id" {
  value = aws_secretsmanager_secret.secretsmanager_secret.id
}

output "secretsmanager_secret_arn" {
  value = aws_secretsmanager_secret.secretsmanager_secret.arn
}

output "secretsmanager_secret_rotation_enabled" {
  value = aws_secretsmanager_secret.secretsmanager_secret.rotation_enabled
}