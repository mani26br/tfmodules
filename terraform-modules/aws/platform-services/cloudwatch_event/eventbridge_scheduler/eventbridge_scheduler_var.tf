variable "eventbridge_scheduler_name" {
  description = "The name of the EventBridge scheduler."
  type        = string
}

variable "eventbridge_scheduler_group_name" {
  description = "The name of the EventBridge scheduler group."
  type        = string
  default     = "default" # set a default if you want to use the default group
}

variable "flexible_time_window_mode" {
  description = "The mode for the flexible time window. Set to 'OFF' to disable flexibility."
  type        = string
  default     = "OFF"
}

variable "flexible_maximum_window_in_minutes" {
  description = "Maximum time window during which a schedule can be invoked. Ranges from 1 to 1440 minutes."
  type = number
  default = 120
}

variable "eventbridge_scheduler_timezone" {
  description = "The timezone for the schedule (e.g., 'America/New_York' for Eastern Time)."
  type        = string
  default     = "America/New_York"
}

variable "eventbridge_scheduler_expression" {
  description = "The schedule expression (e.g., 'rate(1 hour)' or 'cron(0 12 * * ? *)')."
  type        = string
}

variable "eventbridge_scheduler_target_arn" {
  description = "The ARN of the target resource to be triggered by the EventBridge scheduler (e.g., Lambda, SQS ARN)."
  type        = string
}

variable "eventbridge_scheduler_role_arn" {
  description = "The IAM role ARN required for EventBridge to invoke the target resource."
  type        = string
}
