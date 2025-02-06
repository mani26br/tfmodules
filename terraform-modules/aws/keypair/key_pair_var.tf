variable "key_name" {
  type = string
  default = ""
}

variable "key_name_prefix" {
  type = string
  default = null
}

variable "key_public_key" {
  type = string
  default = ""
}

variable "key_tags" {
  type = map
  default = {}
}
