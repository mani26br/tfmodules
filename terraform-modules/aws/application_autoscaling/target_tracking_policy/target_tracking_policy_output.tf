output "app_target_tracking_policy_arn" {
  value = aws_appautoscaling_policy.app_target_tracking_policy.arn
}

output "app_target_tracking_policy_name" {
  value = aws_appautoscaling_policy.app_target_tracking_policy.name
}

output "app_target_tracking_policy_policy" {
  value = aws_appautoscaling_policy.app_target_tracking_policy.policy_type
}
