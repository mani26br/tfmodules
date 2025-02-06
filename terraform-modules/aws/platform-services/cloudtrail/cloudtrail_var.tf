variable "aws_cloudtrail_bucket" {
  type        = string
  default     = ""
}

variable "iam_role_name" {
  type        = string
  default     = "cloudtrail_cloudwatch_role"
}

variable "s3_bucket_tags" {
  type = map
  default = {}
}

variable "retention_period" {
  type    = number
  default = 0
}

variable "aws_splunk_role_name" {
  type        = string
  default     = ""
}

variable "cloudtrail_alias_name" {
  type        = string
  default     = ""
}

variable "environment" {
  type        = string
  default     = ""
}

variable "enabled_cloudtrail" {
  type        = bool
  default     = true
}

variable "trail_name" {
  type        = string
  default     = ""
}

variable "enable_logging" {
  type        = bool
  default     = true
}

variable "enable_log_file_validation" {
  type        = bool
  default     = true
}

variable "is_multi_region_trail" {
  type        = bool
  default     = true
}

variable "include_global_service_events" {
  type        = bool
  default     = true
}

variable "is_organization_trail" {
  type        = bool
  default     = false
}

variable "cloudtrail_tags" {
  type = map
  default = {}
}

variable "sns_topic_name" {
  type        = string
  default     = ""
}

