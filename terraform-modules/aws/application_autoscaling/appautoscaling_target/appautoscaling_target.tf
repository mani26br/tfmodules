resource "aws_appautoscaling_target" "app_autoscaling_target" {
  max_capacity       = var.max_autoscaling_capacity
  min_capacity       = var.min_autoscaling_capacity
  resource_id        = var.autoscaling_resource_id
  scalable_dimension = var.autoscaling_scalable_dimension
  service_namespace  = var.autoscaling_service_namespace
}
