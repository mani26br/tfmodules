variable "network_acl_vpc_id" {
  type = string
  default = ""
}

variable "network_acl_subnet_ids" {
  type = list
  default = []
}

variable "network_acl_egress" {
  type = any
  default = [
    {
      from_port = ""
      to_port = ""
      rule_no = ""
      action = ""
      protocol = ""
      cidr_block = ""
    }
  ]
}

variable "network_acl_ingress" {
  type = any
  default = [
    {
      from_port = ""
      to_port = ""
      rule_no = ""
      action = ""
      protocol = ""
      cidr_block = ""
    }
  ]
}

variable "network_acl_name" {
  type = string
  default = ""
}

variable "network_acl_tags" {
  type = map
  default = {}
}
