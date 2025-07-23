variable "keyvault_keyname" {
  description = "(Required) Specifies the name of the Key Vault Key"
  type = string
  default = ""
}

variable "key_vault_id" {
  description = "(Required) The ID of the Key Vault where the Key should be created."
  type = string
  default = ""
}

variable "key_type" {
  description = "(Required) Specifies the Key Type to use for this Key Vault Key. Possible values are EC (Elliptic Curve), EC-HSM, Oct (Octet), RSA and RSA-HSM."
  type = string
  default = ""
}


variable "key_size" {
  description = "(Optional) Specifies the Size of the RSA key to create in bytes. For example, 1024 or 2048. Note: This field is required if key_type is RSA or RSA-HSM."
  type = string
  default = ""
}

variable "key_opts" {
  type        = list(string)
  description = "(Required) A list of JSON web key operations."
  default     = [ "decrypt", "encrypt", "sign", "unwrapKey", "verify", "list", "listsas",
                  "wrapKey" ]
}
