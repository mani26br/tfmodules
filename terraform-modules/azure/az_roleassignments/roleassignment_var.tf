variable "roleassignment_scope" {
  type    = string
  default = ""
}

variable "roledefinition" {
  type    = string
  default = null
}

variable "roledefinition_name" {
  type    = string
  default = null
}

variable "principalid" {
  type    = string
  default = ""
}

variable "skip_service_principal_aad_check" {
  type    = bool
  default = false
}
