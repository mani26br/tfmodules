variable "iam_role_name" {
  type    = string
  default = ""
}

variable "iam_role_policy_name" {
  type    = string
  default = ""
}

variable "iam_role_policy" {
  type    = string
  default = ""
}

variable "iam_role_name_prefix" {
  type    = string
  default = null
}

variable "iam_role_assume_role_policy" {
  type    = string
  default = ""
}

variable "iam_role_force_detach_policies" {
  type    = bool
  default = false
}

variable "iam_role_path" {
  type    = string
  default = null
}

variable "iam_role_description" {
  type    = string
  default = null
}

variable "iam_role_max_session_duration" {
  type    = string
  default = null
}

variable "iam_role_permissions_boundary" {
  type    = string
  default = null
}

variable "iam_role_tags" {
  type    = map
  default = {}
}
