variable "firewall_rule_name" {
  type = string
  default = ""
}

variable "resource_group_name" {
  type = string
  default = ""
}

variable "mysql_server_name" {
  type = string
  default = ""
}

variable "start_ip_address" {
  type = string
  default = null
}

variable "end_ip_address" {
  type = string
  default = null
}
