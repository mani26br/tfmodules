variable "custom_https_provisioning_enabled" {
  type = bool
  default = false
}

variable "custom_frontend_endpoint" {
  type = string
  default = ""
}

variable "custom_https_configuration" {
  type = any
  default = []
}

variable "frontdoor_name" {
  type = string
  default = ""
}

variable "resource_group_name" {
  type = string
  default = ""
}

variable "enforce_backend_pools_certificate_name_check" {
  type = bool
  default = false
}
