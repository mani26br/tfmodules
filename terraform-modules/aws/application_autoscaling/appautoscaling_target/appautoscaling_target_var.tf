variable "max_autoscaling_capacity" {
  description = "The max capacity of the scalable target"
  type = string
  default = null
}

variable "min_autoscaling_capacity" {
  description = "The min capacity of the scalable target"
  type = string
  default = null
}

variable "autoscaling_resource_id" {
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
  description = "he AWS service namespace of the scalable target"
  type = string
  default = "ecs"
}
