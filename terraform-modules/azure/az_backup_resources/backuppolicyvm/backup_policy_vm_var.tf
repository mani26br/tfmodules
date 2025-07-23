variable "backup_policy_vm_name" {
  type = string
  default = ""
}

variable "backup_policy_vm_resource_group_name" {
  type = string
  default = ""
}

variable "backup_policy_vm_recovery_vault_name" {
  type = string
  default = ""
}

variable "backup_policy_vm_backup" {
  type = any
  default = []
}

variable "backup_policy_vm_timezone" {
  type = string
  default = ""
}

variable "backup_policy_vm_retention_daily" {
  type = any
  default = []
}

variable "backup_policy_vm_retention_weekly" {
  type = any
  default = []
}

variable "backup_policy_vm_retention_monthly" {
  type = any
  default = []
}

variable "backup_policy_vm_retention_yearly" {
  type = any
  default = []
}

variable "backup_policy_vm_tags" {
  type = map
  default = {}
}
