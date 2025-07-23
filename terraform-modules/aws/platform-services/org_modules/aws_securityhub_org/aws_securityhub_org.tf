resource "aws_securityhub_organization_configuration" "securityhub_configuration" {
  auto_enable = true
}

resource "aws_securityhub_standards_subscription" "cis_aws_foundations_benchmark_v1_4_0" {
  standards_arn = "arn:aws:securityhub:::standards/cis-aws-foundations-benchmark/v/1.4.0"
} 


resource "aws_securityhub_standards_subscription" "nist_800_53_v5" {
  standards_arn = "arn:aws:securityhub:::standards/nist-800-53/v/5.0.0"
}