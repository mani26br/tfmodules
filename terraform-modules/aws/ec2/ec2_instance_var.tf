variable "instanceregion" {
  type    = string
  default = ""
}

variable "instance_ami" {
  type    = string
  default = ""
}

variable "instance_type" {
  type    = string
  default = ""
}


variable "instance_subnet" {
  type    = string
  default = null
}

# Note: Please provide or select
variable "auto_instance_public_ip" {
  type    = string
  default = null
}

variable "instance_role" {
  type    = string
  default = ""
}

variable "instance_password_data" {
  type = string
  default = "false"
}

variable "instance_placement_group" {
  type = string
  default = ""
}

variable "instance_ipv6_count" {
  type = string
  default = null
}

variable "instance_ipv6_addresses" {
  type = list
  default = null
}

variable "instance_source_dest_check" {
  type = string
  default = "false"
}

variable "instance_shutdown_behavior" {
  type    = string
  default = "stop"
}

variable "termination_protection" {
  type    = string
  default = "false"
}

variable "instance_monitoring" {
  type    = string
  default = "false"
}

variable "instance_tenancy" {
  type    = string
  default = "default"
}

variable "instance_userdata" {
  type    = string
  default = <<-EOT
    echo "Hallo World"
    EOT
}

#variable "instance_az" {
#  type = stirng
#  default = ""
#}

variable "root_volume" {
  type = list(map(string))
  default = []
}

variable "ebs_volume" {
  type = list(map(string))
  default = []
}

variable "ephemeral_volume" {
  type = list(map(string))
  default = []
}

variable "instance_name" {
  type    = string
  default = ""
}

variable "instance_keyname" {
  type = string
  default = ""
}

variable "instance_vpc_sg_ids" {
  type = list
  default = null
}

variable "appinstance_volume_tags" {
  type = map
  default = {}
}

variable "appinstance_tags" {
  type = map
  default = {}
}

variable "instance_ebs_optimized" {
  type        = bool
  default     = false
}

variable "network_interface" {
  description = "Customize network interfaces to be attached at instance boot time"
  type        = list(map(string))
  default     = []
}

