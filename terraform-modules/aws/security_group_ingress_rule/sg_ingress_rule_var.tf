variable "sg_ingress_rule_id" {
  type = string
}

variable "referenced_sg_ingress_rule_id" {
  type = string
}

variable "sg_ingress_rule_ip_protocol" {
  type = string
  default = "tcp"
}

variable "sg_ingress_rule_from_port" {
  type = number
}

variable "sg_ingress_rule_to_port" {
  type = number
}