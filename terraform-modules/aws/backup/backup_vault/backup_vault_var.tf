variable "backup_vault_name" {
  type    = string
  default = ""
}

variable "backup_vault_tags" {
  type    = map
  default = {}
}

variable "backup_vault_kms_key_arn" {
  type    = string
  default = ""
}
