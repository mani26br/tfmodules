resource "aws_iam_role" "iam_role" {
  name = var.iam_role_name
  name_prefix = var.iam_role_name_prefix
  assume_role_policy = var.iam_role_assume_role_policy
  force_detach_policies = var.iam_role_force_detach_policies
  path = var.iam_role_path
  description = var.iam_role_description
  max_session_duration = var.iam_role_max_session_duration
  permissions_boundary = var.iam_role_permissions_boundary
  tags = merge(tomap({
  "Name"=var.iam_role_name,
  }), var.iam_role_tags)
}

resource "aws_iam_role_policy" "iam_role_policy" {
  name = var.iam_role_policy_name
  role   = aws_iam_role.iam_role.id
  policy = var.iam_role_policy
}
