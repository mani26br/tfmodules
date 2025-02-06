variable "ec2_instance_connect_name" {
  type = string
}

variable "ec2_instance_connect_subnet_id" {
  type = string
}

variable "ec2_instance_connect_security_group_id" {
  type = list(string)
  default = null
}

variable "ec2_instance_connect_preserve_client_ip" {
  type = string
  default = null
}

variable "ec2_instance_connect_tags" {
  type = map(string)
  default = null
}