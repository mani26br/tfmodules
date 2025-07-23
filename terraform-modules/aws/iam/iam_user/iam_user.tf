resource "aws_iam_user" "iam_user" {
  name = var.iam_user_name
  path = var.iam_user_path
  permissions_boundary = var.iam_user_permissions_boundary
  force_destroy = var.iam_user_force_destroy

  tags = merge(tomap({
  "Name"=var.iam_user_name,
  }), var.iam_user_tags)
}
