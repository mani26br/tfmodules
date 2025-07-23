variable "lb_nat_rule_name" {
  type = string
  default = ""
}

variable "lb_nat_rule_rg_name" {
  type = string
  default = ""
}

variable "lb_nat_rule_loadbalancer_id" {
  type = string
  default = ""
}

variable "lb_nat_rule_frontend_ip_config_name" {
  type = string
  default = ""
}

variable "lb_nat_rule_protocol" {
  type = string
  default = ""
}

variable "lb_nat_rule_frontend_port" {
  type = string
  default = ""
}

variable "lb_nat_rule_backend_port" {
  type = string
  default = ""
}

variable "lb_nat_rule_idle_timeout_in_minutes" {
  type = string
  default = ""
}

variable "lb_nat_rule_enable_floating_ip" {
  type = string
  default = "false"
}

variable "lb_nat_rule_enable_tcp_reset" {
  type = string
  default = "false"
}
