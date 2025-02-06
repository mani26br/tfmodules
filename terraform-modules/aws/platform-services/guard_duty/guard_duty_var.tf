variable "finding_publishing_frequency" {
  description = <<-DOC
  The frequency of notifications sent for finding occurrences. If the detector is a GuardDuty member account, the value
  is determined by the GuardDuty master account and cannot be modified, otherwise it defaults to SIX_HOURS.

  For standalone and GuardDuty master accounts, it must be configured in Terraform to enable drift detection.
  Valid values for standalone and master accounts: FIFTEEN_MINUTES, ONE_HOUR, SIX_HOURS."

  For more information, see:
  https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_findings_cloudwatch.html#guardduty_findings_cloudwatch_notification_frequency
  DOC
  type        = string
  default     = "SIX_HOURS"
}

variable "s3_protection_enabled" {
  description = <<-DOC
  Flag to indicate whether S3 protection will be turned on in GuardDuty.

  For more information, see:
  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_detector
  DOC
  type        = bool
  default     = true
}

variable "guardduty_enabled" {
  type        = bool
  default     = true
}

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
