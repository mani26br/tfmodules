

output "iam_user_policy_prefix"{
  value = aws_iam_user_policy.iam_user_policy.policy
}


output "iam_user_policy_id" {
  value = aws_iam_user_policy.iam_user_policy.id
}

output "iam_user_policy_name" {
  value = aws_iam_user_policy.iam_user_policy.name
}

output "iam_user_policy_user" {
  value = aws_iam_user_policy.iam_user_policy.user
}