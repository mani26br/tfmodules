variable "key_vault_secret_name" {
  description = "Please provide key vault secret name (Required)"
  type = string
  default = ""
}

variable "key_vault_secret_value" {
  description = "Please provide secret value (Required)"
  type = string
  default = ""
}

variable "key_vault_id" {
  description = "Please provide key vault id(Required)"
  type = string
  default = ""
}


variable "expiration_date" {
  description = "Please provide secret expiration(optional)"
  type = string
  default = null
}
