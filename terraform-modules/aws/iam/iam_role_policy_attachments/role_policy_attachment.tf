resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  role = var.role_policy_attachment_role
  policy_arn = var.role_policy_attachment_policy_arn
}
