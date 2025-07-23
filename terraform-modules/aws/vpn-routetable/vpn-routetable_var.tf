variable "assign_vpc_id" {
  type = string
  default = ""
}

variable "cidr_block" {
  type = string
  default = ""
}

variable "gateway_id" {
  type = string
  default = ""
}

variable "vpn_routetable_name" {
  type = string
  default = ""
}

variable "vpn_routetable_tags" {
  type = map
  default = {}
}