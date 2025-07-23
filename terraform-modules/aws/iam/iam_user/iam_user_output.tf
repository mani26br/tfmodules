output "iam_user_arn" {
  value = aws_iam_user.iam_user.arn
}

output "iam_user_path" {
  value = aws_iam_user.iam_user.path
}


output "iam_user_permissions_boundary"{
    value = aws_iam_user.iam_user.permissions_boundary
}

output "iam_user_id" {
  value = aws_iam_user.iam_user.id
}

output "iam_user_name" {
  value = aws_iam_user.iam_user.name
}

output "iam_user_unique_id" {
  value = aws_iam_user.iam_user.unique_id
}
