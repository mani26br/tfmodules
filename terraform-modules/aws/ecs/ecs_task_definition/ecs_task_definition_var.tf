variable "task_definition_name" {
  description = "A unique name for the task definition"
  type = string
  default = null
}

variable "task_def_container_definitions" {
  description = "container definition"
  type = string
  default = null
}

variable "task_def_execution_role_arn" {
  description = "ARN of the task execution role that the container agent can assume"
  type = string
  default = null
}

variable "task_def_task_role_arn" {
  description = "ARN of IAM role that allows the container task to make calls to other AWS services"
  type = string
  default = null
}

variable "fargate_cpu" {
  description = "Number of cpu units used by the task"
  type = string
  default = null
}

variable "fargate_memory" {
  description = "The amount (in MiB) of memory used by the task"
  type = string
  default = null
}

variable "ecs_task_definition_tags" {
  description = "Provide the ecs task tags"
  type = map
  default = {}
}

variable "fargate_storage" {
  description = "Volume made available to container"
  type = string
  default = "container-storage"
}
