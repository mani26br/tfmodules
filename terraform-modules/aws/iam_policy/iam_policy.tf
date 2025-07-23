resource "aws_iam_policy" "iam_policy" {
  name        = var.iam_policy_name
  path        = var.iam_policy_path
  description = var.iam_policy_description
  policy      = var.iam_policy_policy
}