variable "bgp_asn" {
  type = string
  default = ""
}

variable "ip_address" {
  type = string
  default = ""
}

variable "customergateway_name" {
  type = string
  default = ""
}

variable "customergateway_tags" {
  type = map
  default = {}
}

variable "type" {
  type = string
  default = "ipsec.1"
}
