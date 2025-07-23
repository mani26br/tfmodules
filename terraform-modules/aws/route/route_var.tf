variable "route_route_table_id" {
  type = string
  default = ""
}

variable "route_destination_cidr_block" {
  type = string
  default = null
}

variable "route_destination_ipv6_cidr_block" {
  type = string
  default = null
}

variable "route_egress_only_gateway_id" {
  type = string
  default = null
}

variable "route_gateway_id" {
  type = string
  default = null
}

variable "route_instance_id" {
  type = string
  default = null
}

variable "route_nat_gateway_id" {
  type = string
  default = null
}

variable "route_network_interface_id" {
  type = string
  default = null
}

variable "route_transit_gateway_id" {
  type = string
  default = null
}

variable "route_vpc_peering_connection_id" {
  type = string
  default = null
}
