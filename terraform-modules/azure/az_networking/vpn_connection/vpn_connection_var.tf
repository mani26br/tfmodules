variable "vpn_connection_name" {
  type = string
  default = ""
}

variable "resource_group_location" {
  type = string
  default = ""
}

variable "local_network_gateway_id" {
  type = string
  default = ""
}

variable "resource_group_name" {
  type = string
  default = ""
}

variable "virtual_network_gateway_id" {
  type = string
  default = ""
}

variable "ipsec_type" {
  type = string
  default = ""
}

variable "shared_key" {
  type = string
  default = ""
}

variable "dpd_timeout_seconds" {
  type = number
  default = 45
}

variable "local_azure_ip_address_enabled" {
  type = bool
  default = false
}

variable "enable_bgp" {
  type = bool
  default = false
}

variable "express_route_gateway_bypass" {
  type = bool
  default = false
}

variable "use_policy_based_traffic_selectors" {
  type = bool
  default = false
}

variable "routing_weight" {
  type = number
  default = 0
}
