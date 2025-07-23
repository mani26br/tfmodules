variable "window_id" {
  description = "The ID of the AWS SSM Maintenance Window associated with the target."
  type        = string
}

variable "name" {
  description = "The name of the AWS SSM Maintenance Window Target."
  type        = string
}

variable "description" {
  description = "The description of the AWS SSM Maintenance Window Target."
  type        = string
}

variable "resource_type" {
  description = "The type of resource targeted by the AWS SSM Maintenance Window."
  type        = string
}

variable "key" {
  type = string
}

variable "values" {
  type = any
}