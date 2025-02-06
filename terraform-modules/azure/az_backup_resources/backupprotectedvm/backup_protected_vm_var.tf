variable "backup_protected_vm_resource_group_name" {
  type = string
  default = ""
}

variable "backup_protected_vm_recovery_vault_name" {
  type = string
  default = ""
}

variable "backup_protected_vm_source_vm_id" {
  type = string
  default = ""
}

variable "backup_protected_vm_backup_policy_id" {
  type = string
  default = ""
}

variable "backup_protected_vm_tags" {
  type = map
  default = {}
}
