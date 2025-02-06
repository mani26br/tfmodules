variable "app_gateway_name" {
  type = string
  default = ""
}

variable "resource_group_name" {
  type = string
  default = ""
}

variable "resource_group_location" {
  type = string
  default = ""
}

variable "sku" {
  type = any
  default = []
}

variable "gateway_ip_configuration" {
  type = any
  default = []
}

variable "frontend_port" {
  type = any
  default = []
}

variable "frontend_ip_configuration" {
  type = any
  default = []
}

variable "backend_address_pool" {
  type = any
  default = []
}

variable "backend_http_settings" {
  type = any
  default = []
}

variable "http_listener" {
  type = any
  default = []
}

variable "request_routing_rule" {
  type = any
  default = []
}
