# Managed Rule
resource "aws_wafv2_web_acl" "wafv2_web_acl" {
  name        = var.wafv2_web_acl_name
  description = var.wafv2_web_acl_description
  scope       = var.wafv2_web_acl_scope

  dynamic "custom_response_body" {
    for_each = var.custom_response_body

    content {
      key          = lookup(custom_response_body.value, "key", null)
      content      = lookup(custom_response_body.value, "content", null)
      content_type = lookup(custom_response_body.value, "content_type", null)
    }
  }

  dynamic "default_action" {
    for_each = var.default_action

    content {
      dynamic "allow" {
        for_each = lookup(default_action.value, "allow", {})
        content {
        }
      }
    }
  }

  dynamic "rule" {
    for_each = var.managed_rules
    content {
      name     = lookup(rule.value, "name", null)
      priority = lookup(rule.value, "priority", null)
      override_action {
        dynamic "none" {
          for_each = lookup(rule.value.override_action == "none" ? [1] : [])
          content {}
        }

        dynamic "count" {
          for_each = rule.value.override_action == "count" ? [1] : []
          content {}
        }
      }

      statement {
        managed_rule_group_statement {
          name        = rule.value.name
          vendor_name = rule.value.vendor_name
          version     = rule.value.version
          dynamic "rule_action_override" {
            for_each = rule.value.rule_action_override
            content {
              name = rule_action_override.value["name"]
              action_to_use {
                dynamic "allow" {
                  for_each = rule_action_override.value["action_to_use"] == "allow" ? [1] : []
                  content {}
                }
                dynamic "block" {
                  for_each = rule_action_override.value["action_to_use"] == "block" ? [1] : []
                  content {}
                }
                dynamic "count" {
                  for_each = rule_action_override.value["action_to_use"] == "count" ? [1] : []
                  content {}
                }
              }
            }
          }
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = rule.value.name
        sampled_requests_enabled   = true
      }
    }
  }

      dynamic "statement" {
        for_each = lookup(rule.value, "statement", {})

        content {
          dynamic "managed_rule_group_statement" {
            for_each = lookup(statement.value, "managed_rule_group_statement", {})

            content {
              name        = lookup(managed_rule_group_statement.value, "name", null)
              vendor_name = lookup(managed_rule_group_statement.value, "vendor_name", null)
              dynamic "excluded_rule" {
                for_each = lookup(managed_rule_group_statement.value, "excluded_rule", {})

                content {
                  name = lookup(excluded_rule.value, "name", null)
                }
              }
            }
          }
          # Added below code for the count rule for the waf
          dynamic "rate_based_statement" {
            for_each = lookup(statement.value, "rate_based_statement", {})
            
            content {
              limit = lookup(rate_based_statement.value, "limit", null)
              aggregate_key_type         = lookup(rate_based_statement.value, "aggregate_key_type", null)
            }
          }
          # End of the rate based statement
        }
      }

      dynamic "visibility_config" {
        for_each = lookup(rule.value, "visibility_config", null)

        content {
          cloudwatch_metrics_enabled = lookup(visibility_config.value, "cloudwatch_metrics_enabled", null)
          metric_name                = lookup(visibility_config.value, "metric_name", null)
          sampled_requests_enabled   = lookup(visibility_config.value, "sampled_requests_enabled", null)
        }
      }
    }
  }

  tags = merge(map(
    "Name", var.wafv2_web_acl_name,
  ), var.wafv2_web_acl_tags)

  dynamic "visibility_config" {
    for_each = var.visibility_config

    content {
      cloudwatch_metrics_enabled = lookup(visibility_config.value, "cloudwatch_metrics_enabled", null)
      metric_name                = lookup(visibility_config.value, "metric_name", null)
      sampled_requests_enabled   = lookup(visibility_config.value, "sampled_requests_enabled", null)
    }
  }
}
