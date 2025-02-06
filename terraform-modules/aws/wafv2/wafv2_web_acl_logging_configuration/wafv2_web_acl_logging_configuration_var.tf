variable "wafv2_web_acl_logging_config_redacted_fields_log_destination_configs" {
  type    = string
  default = ""
}

variable "wafv2_web_acl_arn" {
  type    = string
  default = ""
}

variable "wafv2_web_acl_single_header_name" {
  type    = string
  default = "user-agent"
}

variable "wafv2_web_acl_logging_config_logging_filter_log_destination_configs" {
  type    = string
  default = ""
}


variable "wafv2_web_acl_logging_filter_default_behavior" {
  type    = string
  default = "KEEP"
}

variable "wafv2_web_acl_logging_filter1_behavior" {
  type    = string
  default = "DROP"
}


variable "wafv2_web_acl_logging_filter1_action_condition_action" {
  type    = string
  default = "COUNT"
}

variable "wafv2_web_acl_logging_filter_condition_label_name" {
  type    = string
  default = ""
}


variable "wafv2_web_acl_logging_filter1_requirement" {
  type    = string
  default = "MEETS_ALL"
}

variable "wafv2_web_acl_logging_filter2_behavior" {
  type    = string
  default = "KEEP"
}

variable "wafv2_web_acl_logging_filter2_action_condition_action" {
  type    = string
  default = "ALLOW"
}

variable "wafv2_web_acl_logging_filter2_requirement" {
  type    = string
  default = "MEETS_ANY"
}

