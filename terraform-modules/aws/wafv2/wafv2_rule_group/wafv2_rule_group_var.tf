variable "wafv2_rule_group_name" {
  type    = string
  default = ""
}

variable "wafv2_rule_group_description" {
  type    = string
  default = ""
}

variable "wafv2_rule_group_scope" {
  type    = string
  default = "REGIONAL"
}

variable "wafv2_rule_group_capacity" {
  type    = number
  default = 0
}

variable "wafv2_rule_group_country_codes" {
  type    = list
  default = null
}

variable "wafv2_rule_group_cloudwatch_metrics_enabled" {
  type    = bool
  default = false
}

variable "wafv2_rule_group_rule_metric_name" {
  type    = string
  default = ""
}

variable "wafv2_rule_group_sampled_requests_enabled" {
  type    = bool
  default = false
}

variable "wafv2_rule_group_metric_name" {
  type    = string
  default = ""
}
