resource "aws_secretsmanager_secret_version" "secretsmanager_secret_version" {
  secret_id      = var.aws_secretsmanager_secret_version_secret_id
  secret_string  = var.secretsmanager_secret_version_secret_string
  secret_binary  = var.secretsmanager_secret_version_secret_binary
  version_stages = var.secretsmanager_secret_version_stages
}