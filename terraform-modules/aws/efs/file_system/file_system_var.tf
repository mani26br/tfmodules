variable "file_system_creation_token" {
  type    = string
  default = ""
}

variable "file_system_encrypted" {
  type    = string
  default = "false"
}

variable "file_system_kms_key_id" {
  type    = string
  default = ""
}

variable "file_system_lifecycle_policy" {
  type    = any
  default = {}
}

variable "file_system_performance_mode" {
  type    = string
  default = "generalPurpose"
}

variable "file_system_provisioned_throughput_in_mibps" {
  type    = string
  default = null
}

variable "file_system_name" {
  type    = string
  default = ""
}

variable "file_system_tags" {
  type    = map
  default = {}
}

variable "file_system_throughput_mode" {
  type    = string
  default = "bursting"
}
