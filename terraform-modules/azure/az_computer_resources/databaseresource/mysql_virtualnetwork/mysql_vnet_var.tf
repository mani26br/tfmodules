variable "mysql_vnet_name" {
  description = "Please provide mysql server name (Required)"
  type = string
  default = ""
}

variable "mysql_server_resource_group_name" {
  description = "Please provide mysql server resource group name (Required)"
  type = string
  default = ""
}

variable "mysql_server_name" {
  description = "Please provide mysql server name (Required)"
  type = string
  default = ""
}

variable "mysql_subnet_id" {
  description = "Please provide mysql server subnet (Required)"
  type = string
  default = null
}
