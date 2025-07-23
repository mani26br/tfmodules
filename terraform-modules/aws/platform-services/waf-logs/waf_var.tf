variable "name" {
  type        = string
  description = "A friendly name of the WebACL."
    default = ""
}
variable "WAFV2name" {
  type        = string
  description = "A friendly name of the WebACL."
    default = ""
}

variable "create_aws_wafv2_web_acl" {
  description = "Whether to create the WebACL"
  type        = bool
  default     = false
}
variable "existing_waf" {
  description = "Name of the existing WAF Web ACL"
  type        = string
}


variable "managed_rules" {
  type = list(object({
    name            = string
    priority        = number
    override_action = string
    vendor_name     = string
    version         = string
    rule_action_override = list(object({
      name          = string
      action_to_use = string
    }))
  }))
  description = "List of Managed WAF rules."
  default = [
    {
      name                 = "AWSManagedRulesCommonRuleSet"
      priority             = 10
      override_action      = "none"
      vendor_name          = "AWS"
      version              = "example_version"
      rule_action_override = [],
    },
    {
      name                 = "AWSManagedRulesAmazonIpReputationList"
      priority             = 20
      override_action      = "none"
      vendor_name          = "AWS"
      version              = "example_version"
      rule_action_override = [],
    },
    {
      name                 = "AWSManagedRulesKnownBadInputsRuleSet"
      priority             = 30
      override_action      = "none"
      vendor_name          = "AWS"
      version              = "example_version"
      rule_action_override = [],
    },
    {
      name                 = "AWSManagedRulesSQLiRuleSet"
      priority             = 40
      override_action      = "none"
      vendor_name          = "AWS"
      version              = "example_version"
      rule_action_override = [],
    },
    {
      name                 = "AWSManagedRulesLinuxRuleSet"
      priority             = 50
      override_action      = "none"
      vendor_name          = "AWS"
      version              = "example_version"
      rule_action_override = [],
    },
    {
      name                 = "AWSManagedRulesUnixRuleSet"
      priority             = 60
      override_action      = "none"
      vendor_name          = "AWS"
      version              = "example_version"
      rule_action_override = [],
    },
  ]
}
variable "ip_sets_rule" {
  type        = list(object({
    name          = string
    priority      = number
    ip_set_arn    = string
    action        = string
    response_code = number
  }))
  description = "A rule to detect web requests coming from particular IP addresses or address ranges."
  default     = []
}

variable "ip_rate_based_rule" {
  type        = object({
    name          = string
    priority      = number
    limit         = number
    action        = string
    response_code = number
  })
  description = "A rate-based rule tracks the rate of requests for each originating IP address, and triggers the rule action when the rate exceeds a limit that you specify on the number of requests in any 5-minute time span"
  default     = null
}

variable "ip_rate_url_based_rules" {
  type        = list(object({
    name                  = string
    priority              = number
    limit                 = number
    action                = string
    response_code         = number
    search_string         = string
    positional_constraint = string
  }))
  description = "A rate and URL-based rule tracks the rate of requests for each originating IP address, and triggers the rule action when the rate exceeds a limit that you specify on the number of requests in any 5-minute time span"
  default     = []
}

variable "filtered_header_rule" {
  type = object({
    header_types  = list(string)
    priority      = number
    header_value  = string
    action        = string
    search_string = string
  })
  description = "HTTP header to filter. Currently supports a single header type and multiple header values."
  default = {
    header_types  = []
    priority      = 1
    header_value  = ""
    action        = "block"
    search_string = ""
  }
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the WAFv2 ACL."
  default     = {}
}

variable "associate_alb" {
  type        = bool
  description = "Whether to associate an ALB with the WAFv2 ACL."
  default     = false
}

variable "alb_arns" {
  type        = list(string)
  description = "ARN of the ALB to be associated with the WAFv2 ACL."
  default     = []
}

variable "enable_logging" {
  type        = bool
  description = "Whether to associate Logging resource with the WAFv2 ACL."
  default     = false
}

variable "log_destination_arns" {
  type        = list(string)
  description = "The Amazon Resource Names (ARNs) that you want to associate with the web ACL."
  default     = []
}

variable "environment" {
  type    = string
  default = ""
}

variable "cloudwatch_log_tags" {
  description = "cloudwatch log tags"
  type        = map(string)
  default     = {}
}

variable "wafV2_logs" {
  type    = string
  default = "waf_logs"
}

variable "group_rules" {
  type        = list(map(string))
  description = "List of WAFv2 Rule Groups."
  default     = []
}

variable "default_action" {
  type        = string
  description = "The action to perform if none of the rules contained in the WebACL match."
  default     = "allow"
}
variable "load_balancer_arns" {
  description = "List of load balancer ARNs"
  type        = list(string)
  default = []
}

variable "alb_arns_id" {
  type    = list(string)
  default = []
}
variable "wafV2_cloudwatch_logs" {
  description = "cloudwatch log tags"
  type = map(string)
  default = {}
}

variable "Wafv2_web_acl_arn" {
  description = "Whether to create the WebACL"
  type        = string
  default     = ""
}
variable "aws_wafv2_web_acl" {
  type        = string
  description = "A friendly name of the WebACL."
    default = ""
}
variable "is_cloudfront" {
  description = "Set to true if WebACL is for CloudFront"
  default     = true
}
variable "cloudfront_distribution_ids" {
  description = "A list of CloudFront distribution IDs for association with the WebACL"
  type        = list(string)
  default     = []  # You can provide default values if needed
}