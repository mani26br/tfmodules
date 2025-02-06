variable "secretsmanager_secret_policy_secret_arn" {
  type    = any
  default = null
}

variable "secretsmanager_secret_policy_json" {
  type    = string
  default = null
}

variable "secretsmanager_secret_block_public_policy" {
  type    = bool
  default = false
}