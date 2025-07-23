variable "aws_secretsmanager_secret_version_secret_id" {
  type    = any
  default = null
}

variable "secretsmanager_secret_version_secret_string" {
  type    = string
  default = null
}

variable "secretsmanager_secret_version_secret_binary" {
  type    = string
  default = null
}

variable "secretsmanager_secret_version_stages" {
  type    = list
  default = []
}