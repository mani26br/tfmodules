variable "route_table_vpc_id" {
  type = string
  default = ""
}

variable "route_table_route" {
  type = any
  default = []
}

variable "route_table_name" {
  type = string
  default = ""
}

variable "route_table_tags" {
  type = map
  default = {}
}

variable "route_table_propagating_vgws" {
  type = list
  default = []
}
