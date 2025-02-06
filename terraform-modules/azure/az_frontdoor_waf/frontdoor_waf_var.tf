variable "fd_waf_policy_name" {
  type = string
  default = ""
}

variable "resource_group_name" {
  type = string
  default = ""
}

variable "enabled" {
  type = bool
  default = false
}

variable "mode" {
  type = string
  default = ""
}

variable "redirect_url" {
  type = string
  default = null
}

variable "custom_block_response_status_code" {
  type = number
  default = 403
}

variable "custom_block_response_body" {
  type = string
  default = null
}

variable "custom_rule" {
  type = any
  default = []
}

variable "managed_rule" {
  type = any
  default = []
}
