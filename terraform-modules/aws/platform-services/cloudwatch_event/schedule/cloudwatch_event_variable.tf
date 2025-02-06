variable "cloudwatch_event_rule_name" {
  type = string
}

variable "cloudwatch_event_rule_description" {
  type = string
}

variable "cloudwatch_event_rule_schedule_expression" {
  type = string
  default = "cron(0 12 * * ? *)" 
}

variable "cloudwatch_event_target_id" {
  default = "InvokeLambda"
}

variable "cloudwatch_event_target_arn" {
  type = string
  default = null
}