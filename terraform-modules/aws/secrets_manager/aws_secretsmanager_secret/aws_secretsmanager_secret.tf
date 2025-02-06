resource "aws_secretsmanager_secret" "secretsmanager_secret" {
  name                    = var.secretsmanager_secret_name
  name_prefix             = var.secretsmanager_secret_name_prefix
  description             = var.secretsmanager_secret_description
  kms_key_id              = var.secretsmanager_secret_kms_key_id
  policy                  = var.secretsmanager_secret_policy
  recovery_window_in_days = var.secretsmanager_secret_recovery_window_in_days
  tags                    = var.secretsmanager_secret_tags
}