variable "sns_topic_name" {
  type    = string
  default = ""
}

variable "sns_topic_name_prefix" {
  type    = string
  default = null
}

variable "sns_topic_display_name" {
  type    = string
  default = null
}

variable "sns_topic_policy" {
  type    = string
  default = ""
}

variable "sns_topic_delivery_policy" {
  type    = string
  default = null
}

variable "sns_topic_application_success_feedback_role_arn" {
  type    = string
  default = null
}

variable "sns_topic_application_success_feedback_sample_rate" {
  type    = string
  default = null
}

variable "sns_topic_application_failure_feedback_role_arn" {
  type    = string
  default = null
}

variable "sns_topic_http_success_feedback_role_arn" {
  type    = string
  default = null
}

variable "sns_topic_http_success_feedback_sample_rate" {
  type    = string
  default = null
}

variable "sns_topic_http_failure_feedback_role_arn" {
  type    = string
  default = null
}

variable "sns_topic_kms_master_key_id" {
  type    = string
  default = null
}

variable "sns_topic_lambda_success_feedback_role_arn" {
  type    = string
  default = null
}

variable "sns_topic_lambda_success_feedback_sample_rate" {
  type    = string
  default = null
}

variable "sns_topic_lambda_failure_feedback_role_arn" {
  type    = string
  default = null
}

variable "sns_topic_sqs_success_feedback_role_arn" {
  type    = string
  default = null
}

variable "sns_topic_sqs_success_feedback_sample_rate" {
  type    = string
  default = null
}

variable "sns_topic_sqs_failure_feedback_role_arn" {
  type    = string
  default = null
}

variable "sns_topic_tags" {
  type    = map
  default = {}
}
