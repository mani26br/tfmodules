variable "secretsmanager_secret_name" {
  type    = string
  default = null
}

variable "secretsmanager_secret_name_prefix" {
  type    = string
  default = null
}

variable "secretsmanager_secret_description" {
  type    = string
  default = null
}

variable "secretsmanager_secret_kms_key_id" {
  type    = string
  default = null
}

variable "secretsmanager_secret_policy" {
  type    = string
  default = null
}

variable "secretsmanager_secret_recovery_window_in_days" {
  type    = number
  default = 30
}

variable "secretsmanager_secret_tags" {
  type    = map
  default = {}
}