output "profile_role_arn" {
  value = aws_iam_instance_profile.ec2_profile.arn
}

output "ec2_profile_name" {
  value = aws_iam_instance_profile.ec2_profile.name
}
