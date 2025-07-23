variable "network_interface_name" {
  type = string
  default = ""
}

variable "subnet_id" {
  type = string
  default = ""
}

variable "private_ips" {
  type = list
  default = []
}

variable "security_groups" {
  type = list
  default = []
}

variable "network_interface_tags" {
  type = map
  default = {}
}
