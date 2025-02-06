variable "iam_user_name" {
  type    = string
  default = ""
}

variable "iam_user_path" {
  type    = string
  default = "/"
}

variable "iam_user_permissions_boundary" {
  type    = string
  default = null
}

variable "iam_user_force_destroy" {
    type = string
    default = null
}

variable "iam_user_tags" {
  type    = map
  default = {}
}
