variable "lb_name" {
  type = string
  default = ""
}

variable "lb_rg_name" {
  type = string
  default = ""
}

variable "lb_rg_location" {
  type = string
  default = ""
}

variable "lb_frontend_ip_configuration" {
  type = any
  default = {}
}

variable "lb_sku" {
  type = string
  default = ""
}

variable "lb_sku_tier" {
  type = string
  default = ""
}

variable "lb_tags" {
  type = map
  default = {}
}
