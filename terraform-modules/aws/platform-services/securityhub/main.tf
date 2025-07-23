data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "aws_securityhub_account" "default" {
  count = var.security_hub_enabled && var.enable ? 1 : 0
  enable_default_standards = var.enable_default_standards
}

resource "aws_securityhub_standards_subscription" "cis_aws_foundations_benchmark_v1_4_0" {
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/cis-aws-foundations-benchmark/v/1.4.0"
  depends_on    = [aws_securityhub_account.default]
} 


resource "aws_securityhub_standards_subscription" "nist_800_53_v5" {
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/nist-800-53/v/5.0.0"
  depends_on    = [aws_securityhub_account.default]
}