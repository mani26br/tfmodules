variable "launch_template_name" {
  description = "Provide the name of the template"
  type = string
  default = ""
}

variable "launch_instance_type" {
  description = "Provide the name of the instance type"
  type = string
  default = ""
}

variable "launch_template_image_id" {
  description = "Provide the ami id for the instance"
  type = string
  default = ""
}

variable "launch_template_description" {
  description = "Provide the description of launch template"
  type = string
  default = ""
}

variable "launch_template_ssh_key" {
  description = "Provide the ssh key for the launch template"
  type = string
  default = ""
}

variable "launch_template_user_data" {
  description = "User data used for the instance"
  type = string
  default = ""
}

variable "launch_template_block_device_name" {
  description = "Block device name of the instance"
  type = string
  default = "/dev/xvda"
}

variable "launch_template_volume_size" {
  description = "Block device size"
  type = string
  default = "20"
}

variable "launch_template_volume_type" {
  description = "Block device volume type"
  type = string
  default = "gp2"
}

variable "launch_template_ebs_delete_on_termination" {
  description = "If volume should be destroyed on instance termination"
  type = bool
  default = true
}

variable "launch_template_vpc_security_group_ids" {
  description = "Provide the template source security group ids"
  type = list
  default = []
}

variable "launch_template_instance_name" {
  description = "Name of launch template instances"
  type = string
  default = "EKS-MANAGED-NODE"
}
