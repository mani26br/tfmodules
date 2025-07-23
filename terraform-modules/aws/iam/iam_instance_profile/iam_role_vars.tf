variable "ec2_profile_name" {
  type    = string
  default = ""
}

variable "iam_role_name" {
  type    = string
  default = null
}

variable "role_tags" {
  type    = map(string)
  default = {}
}