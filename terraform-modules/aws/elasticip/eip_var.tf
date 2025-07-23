variable "eip_to_vpc" {
  description = "Please provide Vpc to which it need to attach"
  type = string
  default = null
}

variable "eip_to_instance" {
  description = "Please provide Instance to which it need to attach"
  type = string
  default = null
}

variable "eip_network_interface" {
  description = "Please provide network interface"
  type = string
  default = null
}

variable "eip_associate_with_private_ip" {
  description = "Shoud it need to associate with private ip"
  type = string
  default = null
}

variable "eip_name" {
  description = "Please provide Elasitc ip name"
  type = string
  default = ""
}

variable "eip_tags" {
  description = "Please provide tags"
  type = map
  default = {}
}

variable "eip_public_ipv4_pool" {
  description = "Public IPV4 pool"
  type = string
  default = null
}
