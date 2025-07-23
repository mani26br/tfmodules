variable "sg_name" {
  type = string
  default = ""
}

variable "sg_name_prefix" {
  type = string
  default = null
}

variable "sg_description" {
  type = string
  default = null
}

variable "assign_vpc_id" {
  type = string
  default = ""
}

variable "sg_ingress" {
  type = any
  default = []
}

variable "sg_egress" {
  type = any
  default = []
}

variable "sg_tags" {
  description = "Please provide tags to sg"
  type = map
  default = {}
}

variable "sg_ingress_rule_create" {
  type = bool
  default = false
}

variable "sg_ingress_rule_id" {
  type = string
  default = null
}

variable "referenced_sg_ingress_rule_id" {
  type = string
  default = null
}

variable "sg_ingress_rule_ip_protocol" {
  type = string
  default = "tcp"
}

variable "sg_ingress_rule_from_port" {
  type = number
  default = null
}

variable "sg_ingress_rule_to_port" {
  type = number
  default = null
}