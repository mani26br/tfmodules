variable "vpn_gateway_id" {
  type = string
  default = null
}

variable "customer_gateway_id" {
  type = string
  default = ""
}

variable "vpnconnection_tags" {
  type = map
  default = {}
}

variable "static_routes_only" {
  type  = string
  default = ""
}

variable "tunnel1_preshared_key" {
  type = string
  default = ""
}

variable "tunnel2_preshared_key" {
  type = string
  default = ""
}

variable "type" {
  type = string
  default = "ipsec.1"
}

variable "vpnconnection_name" {
  type = string
  default = ""
}
