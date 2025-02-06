variable "transfer_server_name" {
  type = string
  default = ""
}

variable "transfer_vpc_id" {
  type = string
  default = ""
}

variable "transfer_auto_accept" {
  type = string
  default = null
}

variable "transfer_policy" {
  type = string
  default = null
}

variable "transfer_private_dns_enable" {
  type = string
  default = "false"
}

variable "transfer_route_table_ids" {
  type = list
  default = []
}

variable "transfer_subnet_ids" {
  type = list
  default = []
}

variable "transfer_security_group_ids" {
  type = list
  default = []
}

variable "transfer_tags" {
  type = map
  default = {}
}

variable "transfer_vpc_endpoint_type" {
  type = string
  default = null
}
