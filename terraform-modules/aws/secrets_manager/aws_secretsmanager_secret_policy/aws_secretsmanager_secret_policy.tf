resource "aws_secretsmanager_secret_policy" "secretsmanager_secret_policy" {
  secret_arn = var.secretsmanager_secret_policy_secret_arn
  policy  = var.secretsmanager_secret_policy_json
  block_public_policy     = var.secretsmanager_secret_block_public_policy
}