variable "nat_gateway_name" {
  type = string
  default = ""
}

variable "nat_gateway_resource_group_name" {
  type = string
  default = ""
}

variable "nat_gateway_location" {
  type = string
  default = ""
}

variable "nat_gateway_idle_timeout_min" {
  type = string
  default = "4"
}

variable "nat_gateway_public_ip_add" {
  type = list
  default = []
}

variable "nat_gateway_public_ip_prefix" {
  type = list
  default = []
}

variable "nat_gateway_sku_name" {
  type = string
  default = "Standard"
}

variable "nat_gateway_tags" {
  type = map
  default = {}
}

variable "nat_gateway_zones" {
  type = list
  default = []
}
