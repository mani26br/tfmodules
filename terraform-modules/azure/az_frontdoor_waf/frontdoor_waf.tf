resource "azurerm_frontdoor_firewall_policy" "front-door-waf-policy" {
  name                              = var.fd_waf_policy_name
  resource_group_name               = var.resource_group_name
  enabled                           = var.enabled
  mode                              = var.mode
  redirect_url                      = var.redirect_url
  custom_block_response_status_code = var.custom_block_response_status_code
  custom_block_response_body        = var.custom_block_response_body
  
  dynamic "custom_rule" {
    for_each = var.custom_rule
    content {
      name     = "${lookup(custom_rule.value, "name", null)}"
      action   = "${lookup(custom_rule.value, "action", null)}"
      enabled  = "${lookup(custom_rule.value, "enabled", null)}"
      priority = "${lookup(custom_rule.value, "priority", null)}"
      type     = "${lookup(custom_rule.value, "type", null)}"
      rate_limit_duration_in_minutes = "${lookup(custom_rule.value, "rate_limit_duration_in_minutes", null)}"
      rate_limit_threshold           = "${lookup(custom_rule.value, "rate_limit_threshold", null)}"
      dynamic "match_condition" {
        for_each = lookup(custom_rule.value, "match_condition", [])
        content {
          match_variable     = "${lookup(match_condition.value, "match_variable", null)}"
          match_values       = "${lookup(match_condition.value, "match_values", null)}"
          operator           = "${lookup(match_condition.value, "operator", null)}"
          selector           = "${lookup(match_condition.value, "selector", null)}"
          negation_condition = "${lookup(match_condition.value, "negation_condition", null)}"
          transforms         ="${lookup(match_condition.value, "transforms", null)}"
      }
    }
  }
 }

  dynamic "managed_rule" {
    for_each = var.managed_rule
    content {
      type    =  "${lookup(managed_rule.value, "type", null)}"
      version = "${lookup(managed_rule.value, "version", null)}"


      dynamic "exclusion" {
        for_each = "${lookup(managed_rule.value, "exclusion", [])}"
        content {
          match_variable = "${lookup(exclusion.value, "match_variable", null)}"
          operator       = "${lookup(exclusion.value, "operator", null)}"
          selector       = "${lookup(exclusion.value, "selector", null)}"
        }
      }
      dynamic "override" {
        for_each = "${lookup(managed_rule.value, "override", [])}"
        content {
          rule_group_name = "${lookup(override.value, "rule_group_name", null)}"

          dynamic "exclusion" {
            for_each = "${lookup(override.value, "exclusion", [])}"
            content {
              match_variable = "${lookup(exclusion.value, "match_variable", null)}"
              operator       = "${lookup(exclusion.value, "operator", null)}"
              selector       = "${lookup(exclusion.value, "selector", null)}"
            }
          }

          dynamic "rule" {
            for_each = "${lookup(override.value, "rule", [])}"
            content {
              rule_id = "${lookup(rule.value, "rule_id", null)}"
              action  = "${lookup(rule.value, "action", null)}"
              enabled = "${lookup(rule.value, "enabled", null)}"

              dynamic "exclusion" {
                for_each = "${lookup(rule.value, "exclusion", [])}"
                content {
                  match_variable = "${lookup(exclusion.value, "match_variable", null)}"
                  operator       = "${lookup(exclusion.value, "operator", null)}"
                  selector       = "${lookup(exclusion.value, "selector", null)}"
                }
              }
            }
          }
        }
      }

    }
  }
 
 }

