variable "mount_target_file_system_id" {
  type    = string
  default = ""
}

variable "mount_target_subnet_id" {
  type    = string
  default = ""
}

variable "mount_target_ip_address" {
  type    = string
  default = ""
}

variable "mount_target_security_groups" {
  type    = list
  default = []
}
