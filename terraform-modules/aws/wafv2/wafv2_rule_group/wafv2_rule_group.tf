resource "aws_wafv2_rule_group" "wafv2_rule_group" {
  name        = var.wafv2_rule_group_name
  description = var.wafv2_rule_group_description
  scope       = var.wafv2_rule_group_scope
  capacity    = var.wafv2_rule_group_capacity

  dynamic "regular_expression" {
    for_each = var.wafv2_regex_string
    content {
      regex_string = lookup(regular_expression.value, "regex_string", null)
    }
  }

  dynamic "rule" {
    for_each = var.aws_wafv2_rules
    content {
      name     = lookup(rule.value, "name", null)
      priority = lookup(rule.priority, "priority", null)
    }

    action {
      allow {}
    }

    statement {

      geo_match_statement {
        country_codes = var.wafv2_rule_group_country_codes
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = var.wafv2_rule_group_cloudwatch_metrics_enabled
      metric_name                = var.wafv2_rule_group_rule_metric_name
      sampled_requests_enabled   = var.wafv2_rule_group_sampled_requests_enabled
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = var.wafv2_rule_group_cloudwatch_metrics_enabled
    metric_name                = var.wafv2_rule_group_metric_name
    sampled_requests_enabled   = var.wafv2_rule_group_sampled_requests_enabled
  }
}
