variable "rg_name" {
  type = string
  default = ""
}

variable "rg_location" {
  type = string
  default = ""
}

variable "virtual_network_name" {
  description = "Please provide virtual network name (Required)"
  type = string
  default = ""
}

variable "virtual_network_address_space" {
  description = "Please provide address space for virtula network"
  type = list
  default = ["172.10.0.0/16"]
}

variable "virtual_network_ddos_protection_plan" {
  description = "Please provide ddos protection plan for virtual network"
  type = list(map(string))
  default = []
}

variable "virtual_network_dns_servers" {
  description = "Please provide dns servers for virtual group"
  type = list
  default = null
}

variable "virtual_network_subnet" {
  description = "Please provide subnet for virtual network"
  type = list(map(string))
  default = []
}

variable "virtual_network_tags" {
  description = "Please provide tags for virtual network"
  type = map
  default = {}
}
