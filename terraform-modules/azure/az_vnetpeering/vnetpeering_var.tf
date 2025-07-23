variable "virtual_network_peering_name" {
  type = string
  default = ""
}

variable "virtual_network_name" {
  type = string
  default = ""
}

variable "remote_virtual_network_id" {
  type = string
  default = ""
}

variable "resource_group_name" {
  type = string
  default = ""
}

variable "allow_virtual_network_access" {
  type = bool
  default = true
}

variable "allow_forwarded_traffic" {
  type = bool
  default = false
}

variable "allow_gateway_transit" {
  type = bool
  default = false
}
