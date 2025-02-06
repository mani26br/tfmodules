variable "mysql_id" {
  description = "(Required) The ID of the MySQL Server"
  type = string
  default = ""
}

variable "key_vault_key_url" {
  description = " (Required) The URL to a Key Vault Key."
  type = string
  default = ""
}
