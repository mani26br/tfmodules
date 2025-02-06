variable "servicebus_queue_name" {
  type = string
  default = ""
}

variable "resource_group_name" {
  type = string
  default = ""
}

variable "enable_partitioning" {
  type = bool
  default = true
}

variable "servicebus_namespace_name" {
  type = string
  default = null
}