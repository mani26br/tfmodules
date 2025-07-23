variable "ecs_service_name" {
  description = "A unique name for the ecs service"
  type = string
  default = null
}

variable "ecs_service_cluster" {
  description = "ecs cluster group name"
  type = string
  default = null
}

variable "ecs_service_desired_count" {
  description = "minimum number of instances of the task definition to be kept running"
  type = string
  default = null
}

variable "ecs_platform_version" {
  description = "Fargate platform version"
  type = string
  default = "1.4.0"
}

variable "ecs_task_definition_arn" {
  description = "ecs task definition arn"
  type = string
  default = null
}

variable "ecs_service_health_chk_grace_period" {
  description = "health check grace period"
  type = string
  default = null
}

variable "ecs_service_tags" {
  description = "service specific tags"
  type = map
  default = {}
}

variable "ecs_service_subnet_ids" {
  description = "service private subnets"
  type = string
  default = null
}

variable "ecs_service_sg" {
  description = "Container security group"
  type = string
  default = null
}

variable "ecs_service_lb_target_group_arn" {
  description = "The ARN of the Load Balancer target group"
  type = string
  default = null
}

variable "ecs_service_container_name" {
  description = "name of the container in the container definition"
  type = string
  default = null
}

variable "ecs_service_container_port" {
  description = "name of the port in the container definition"
  type = string
  default = null
}

variable "ecs_service_minimum_healthy_percent" {
  description = "lower limit (as a percentage of the service's desiredCount) of the number of running tasks"
  type = string
  default = 100
}

variable "ecs_service_maximum_percent" {
  description = "upper limit (as a percentage of the service's desiredCount) of the number of running tasks"
  type = string
  default = 200
}

variable "ecs_service_managed_tags" {
  description = "enable Amazon ECS managed tags"
  type = bool
  default = true
}
