variable "subnet_cidr_block" {
  type = string
  default = ""
}

variable "subnet_public_ip_on_launch" {
  type = string
  default = ""
}

variable "subnet_az" {
  type = string
  default = ""
}

variable "subnet_associate_vpc_id" {
  type = string
  default = ""
}

variable "subnet_name" {
  type = string
  default = ""
}

variable "subnet_tags" {
  type = map
  default = {}
}
