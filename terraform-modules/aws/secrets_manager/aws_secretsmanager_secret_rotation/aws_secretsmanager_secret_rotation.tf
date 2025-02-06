resource "aws_secretsmanager_secret_rotation" "secretsmanager_secret_rotation" {
  secret_id                = var.secretsmanager_secret_rotation_rotation_secret_id
  rotation_lambda_arn      = var.secretsmanager_secret_rotation_rotation_lambda_arn
  
  rotation_rules {
    automatically_after_days = var.secretsmanager_secret_rotation_automatically_after_days
  }
}