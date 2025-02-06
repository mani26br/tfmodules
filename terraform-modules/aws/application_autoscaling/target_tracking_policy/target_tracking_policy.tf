resource "aws_appautoscaling_policy" "app_target_tracking_policy" {
  name               = var.target_tracking_policy_name
  policy_type        = "TargetTrackingScaling"
  resource_id        = var.autoscaling_ecs_target_resource_id
  scalable_dimension = var.autoscaling_scalable_dimension
  service_namespace  = var.autoscaling_service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.target_tracking_policy_metric_type
    }
    target_value       = var.target_tracking_policy_target_value
    scale_in_cooldown  = var.target_tracking_policy_scalein_cooldown
    scale_out_cooldown = var.target_tracking_policy_scaleout_cooldown
  }
}
