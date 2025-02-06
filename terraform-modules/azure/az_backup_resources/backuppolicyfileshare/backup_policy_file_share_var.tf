variable "backup_policy_file_share_name" {
  type = string
  default = ""
}

variable "backup_policy_file_share_resource_group_name" {
  type = string
  default = ""
}

variable "backup_policy_file_share_recovery_vault_name" {
  type = string
  default = ""
}

variable "backup_policy_file_share_backup" {
  type = any
  default = []
}

variable "backup_policy_file_share_timezone" {
  type = string
  default = ""
}

variable "backup_policy_file_share_retention_daily" {
  type = any
  default = []
}

variable "backup_policy_file_share_retention_weekly" {
  type = any
  default = []
}

variable "backup_policy_file_share_retention_monthly" {
  type = any
  default = []
}

variable "backup_policy_file_share_retention_yearly" {
  type = any
  default = []
}
