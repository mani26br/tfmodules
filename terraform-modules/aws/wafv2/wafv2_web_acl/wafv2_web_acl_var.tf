variable "wafv2_web_acl_name" {
  type    = string
  default = ""
}

variable "wafv2_web_acl_description" {
  type    = string
  default = ""
}

variable "wafv2_web_acl_scope" {
  type    = string
  default = ""
}

variable "custom_response_body" {
  type    = any
  default = [{}]
}

variable "default_action" {
  type    = any
  default = [{}]
}

variable "default_action_allow" {
  type    = any
  default = [{}]
}

variable "wafv2_web_acl_rule" {
  type    = any
  default = [{}]
}

variable "visibility_config" {
  type    = any
  default = [{}]
}

variable "wafv2_web_acl_tags" {
  type    = map(any)
  default = {}
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
      rule_action_override = [
        {
          name = "Log4JRCE"
        },
        {
          name = "Log4JRCE_ALL_HEADER"
        }

      ],
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
