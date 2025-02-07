variable "enable_findings_publishing" {
  type        = bool
  default     = true
}

variable "guardduty_logs_s3_bucket" {
  type    = string
  default = ""
}

variable "guarddutyevent_name" {
  type    = string
  default = ""
}

variable "guarddutyevent_description" {
  type    = string
  default = ""
}

variable "tags" {
  type = map
  default = {}
}

variable "guraduty_target_id" {
  type    = string
  default = "SendToSNS"
}

variable "notification_arn" {
  type    = string
  default = ""
}

variable "gd_kms_alias_name" {
  type    = string
  default = ""
}

variable "aws_gddetector_id" {
  type    = string
  default = ""
}

variable "guardduty_enabled" {
  type    = bool
  default = true
}

