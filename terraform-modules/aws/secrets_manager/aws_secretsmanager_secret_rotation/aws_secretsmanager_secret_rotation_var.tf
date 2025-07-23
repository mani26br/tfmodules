variable "secretsmanager_secret_rotation_rotation_secret_id" {
  type    = any
  default = null
}

variable "secretsmanager_secret_rotation_rotation_lambda_arn" {
  type    = string
  default = null
}

variable "secretsmanager_secret_rotation_automatically_after_days" {
  type    = number
  default = 30
}