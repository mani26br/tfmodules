variable "frontdoor_name" {
  type = string
  default = ""
}

variable "resource_group_name" {
  type = string
  default = ""
}

variable "enforce_backend_pools_certificate_name_check" {
  type = bool
  default = false
}

variable "forward_routing_rule" {
  type = any
  default = []
}

variable "redirect_routing_rule" {
  type = any
  default = []
}

variable "backend_pool_load_balancing" {
  type = any
  default = []
}

variable "backend_pool_health_probe" {
  type = any
  default = []
}

variable "app_backend_pool" {
  type = any
  default = []
}

variable "frontend_endpoint" {
  type = any
  default = []
}

variable "load_balancing_name" {
  type = string
  default = ""
}

variable "health_probe_name" {
  type = string
  default = ""
}

variable "backend_pools_send_receive_timeout_seconds" {
  type = number
  default = 120
}
