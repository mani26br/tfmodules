variable "sns_topic_subscription_topic_arn" {
  type    = string
  default = ""
}

variable "sns_topic_subscription_protocol" {
  type    = string
  default = ""
}

variable "sns_topic_subscription_endpoint" {
  type    = string
  default = ""
}

variable "sns_topic_subscription_endpoint_auto_confirms" {
  type    = string
  default = "false"
}

variable "sns_topic_subscription_confirmation_timeout_in_minutes" {
  type    = string
  default = null
}

variable "sns_topic_subscription_raw_message_delivery" {
  type    = string
  default = "false"
}

variable "sns_topic_subscription_filter_policy" {
  type    = string
  default = null
}

variable "sns_topic_subscription_delivery_policy" {
  type    = string
  default = null
}
