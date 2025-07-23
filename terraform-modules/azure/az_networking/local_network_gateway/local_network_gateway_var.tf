variable "local_network_gateway_name" {
  type = string
  default = ""
}

variable "resource_group_location" {
  type = string
  default = ""
}

variable "local_gateway_address" {
  type = string
  default = ""
}

variable "resource_group_name" {
  type = string
  default = ""
}

variable "local_gateway_address_space" {
  type = any
  default = []
}

variable "bgp_settings" {
  type = any
  default = []
}
