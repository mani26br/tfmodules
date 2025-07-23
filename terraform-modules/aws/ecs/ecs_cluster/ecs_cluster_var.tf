variable "ecs_cluster_name" {
  description = "ECS cluster name"
  type = string
  default = null
}

variable "ecs_cluster_providers" {
  description = "ECS cluster providers"
  type = any
  default = []
}

variable "ecs_cluster_tags" {
  type = map
  default = {}
}

variable "ecs_insight_value" {
  type = string
  default = "enabled"
}