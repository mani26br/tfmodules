variable "lb_listener_load_balancer_arn" {
  type = string
  default = ""
}

variable "lb_listener_port" {
  type = number
  default = 443
}

variable "lb_listener_protocol" {
  type = string
  default = "HTTPS"
}

variable "lb_listener_ssl_policy" {
  type = string
  default = null
}

variable "lb_listener_certificate_arn" {
  type = string
  default = null
}

variable "lb_listener_default_action" {
  type = any
  default = [
    {
      type = ""
      target_group_arn = ""
    }
  ]
}

variable "lb_listener_tags" {
  type = map
  default = {}
}
