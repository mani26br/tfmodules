variable "resource_group_name_location" {
  type = string
  default = ""
}

variable "disk_encryption_set" {
  type = string
  default = ""
}

variable "resource_group_name" {
  type = string
  default = ""
}

variable "keyvault_id" {
  type = string
  default = ""
}

variable "vm_identity" {
  description = "Please provide mysqlidentity"
  type = list(map(string))
  default = []
}
