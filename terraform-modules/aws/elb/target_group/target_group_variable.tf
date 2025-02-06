variable "target_group_name" {
  type = string
  default = ""
}

variable "target_group_name_prefix" {
  type = string
  default = null
}

variable "target_group_port" {
  type = number
}

variable "target_group_protocol" {
  type = string
  default = ""
}

variable "target_group_vpc_id" {
  type = string
  default = ""
}

variable "target_group_deregistration_delay" {
  type = string
  default = null
}

variable "target_group_slow_start" {
  type = string
  default = null
}

variable "target_group_load_balancing_algorithm_type" {
  type = string
  default = "round_robin"
}

variable "target_group_lambda_multi_value_headers_enabled" {
  type = bool
  default = false
}

variable "target_group_proxy_protocol_v2" {
  type = bool
  default = false
}

#changed data type
variable "target_group_stickiness" {
  type = any
  default = {}
}

variable "target_group_health_check" {
  type = map
  default = {}
}

variable "target_group_target_type" {
  type = string
  default = null
}

variable "target_group_tags" {
  type = map
  default = {}
}
