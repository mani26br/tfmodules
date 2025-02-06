variable "backup_selection_name" {
  type    = string
  default = ""
}

variable "backup_selection_plan_id" {
  type    = string
  default = ""
}

variable "backup_selection_iam_role_arn" {
  type    = string
  default = ""
}

variable "backup_selection_tag" {
  type    = map(any)
  default = {}
}

variable "backup_selection_resources" {
  type    = list(string)
  default = []
}
