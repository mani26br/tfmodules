variable "target_tracking_policy_name" {
  description = "The name of the policy"
  type = string
  default = null
}

variable "autoscaling_ecs_target_resource_id" {
  description = "The resource type and unique identifier string for the resource"
  type = string
  default = null
}

variable "autoscaling_scalable_dimension" {
  description = "The scalable dimension of the scalable target"
  type = string
  default = "ecs:service:DesiredCount"
}

variable "autoscaling_service_namespace" {
  description = "The AWS service namespace of the scalable target"
  type = string
  default = "ecs"
}

variable "target_tracking_policy_metric_type" {
  description = "A predefined metric"
  type = string
  default = null
}

variable "target_tracking_policy_target_value" {
  description = "The target value for the metric"
  type = string
  default = null
}

variable "target_tracking_policy_scalein_cooldown" {
  description = "The amount of time, in seconds, before another scale in activity can start"
  type = string
  default = null
}

variable "target_tracking_policy_scaleout_cooldown" {
  description = "The amount of time, in seconds, before another scale out activity can start"
  type = string
  default = null
}
