variable "description" {
  type        = string
  description = "Description of the DLM policy"
}

variable "execution_role_arn" {
  type        = string
  description = "IAM role ARN for the DLM policy"
}

variable "state" {
  type        = string
  default     = "ENABLED"
  description = "Lifecycle policy state"
}

variable "resource_types" {
  type        = list(string)
  default     = ["VOLUME"]
  description = "Types of resources the policy applies to"
}

variable "dlm_policy_name" {
  type        = string
  description = "Name of the schedule"
}

variable "target_tags" {
  type        = map(string)
  description = "Target tags for identifying resources"
}

variable "dlm_tags" {
  description = "Additional tags for the dlm lifecycle"
  type        = map(string)
  default     = {}
}

variable "schedules" {
  type = map(object({
    create_rule = object({
      interval      = number
      interval_unit = string
      times         = list(string)
    })
    retain_rule = object({
      count = number
    })
    tags_to_add = map(string)
    copy_tags   = bool
  }))
}