resource "aws_iam_policy" "enforce-mfa-iam-group-policy" {
  name        = var.iam_policy_name
  path        = var.iam_policy_path
  description = var.iam_policy_description
  policy      = data.aws_iam_policy_document.NCATSMFAEnforcementPolicy.json
}
