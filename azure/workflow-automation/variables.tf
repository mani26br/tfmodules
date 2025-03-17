variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "storage_account_resource_group_name" {
  description = "The name of the resource group for the storage account"
  type        = string
}

variable "storage_account_location" {
  description = "The location of the storage account"
  type        = string
}

variable "storage_account_account_tier" {
  description = "The tier of the storage account (Standard or Premium)"
  type        = string
}

variable "common_tags" {
  type    = map(any)
  default = {}
}
