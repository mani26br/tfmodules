variable "lb_backend_address_pool_name" {
  type = string
  default = ""
}

variable "lb_backend_address_pool_lb_id" {
  type = string
  default = ""
}

variable "lb_backend_address_pool_tunnel_interface" {
  type = any
  default = {}
}
