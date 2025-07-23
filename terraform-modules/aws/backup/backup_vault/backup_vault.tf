resource "aws_backup_vault" "backup_vault" {
  name = var.backup_vault_name
  tags = var.backup_vault_tags
  kms_key_arn = var.backup_vault_kms_key_arn
}
