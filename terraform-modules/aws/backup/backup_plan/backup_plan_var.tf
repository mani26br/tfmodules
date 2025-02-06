variable "backup_plan_name" {
  type    = string
  default = ""
}

variable "backup_plan_rule" {
  type    = any
  default = [{}]
}

variable "backup_plan_tags" {
  type    = map
  default = {}
}
