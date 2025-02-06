# With Redacted Fields
resource "aws_wafv2_web_acl_logging_configuration" "wafv2_web_acl_logging_configuration_redacted_fields" {
  log_destination_configs = var.wafv2_web_acl_logging_config_redacted_fields_log_destination_configs
  resource_arn            = var.wafv2_web_acl_arn
  redacted_fields {
    single_header {
      name = var.wafv2_web_acl_single_header_name
    }
  }
}

# With Logging Filter
resource "aws_wafv2_web_acl_logging_configuration" "wafv2_web_acl_logging_configuration_logging_filter" {
  log_destination_configs = var.wafv2_web_acl_logging_config_logging_filter_log_destination_configs
  resource_arn            = var.wafv2_web_acl_arn

  logging_filter {
    default_behavior = var.wafv2_web_acl_logging_filter_default_behavior

    filter {
      behavior = var.wafv2_web_acl_logging_filter1_behavior

      condition {
        action_condition {
          action = var.wafv2_web_acl_logging_filter1_action_condition_action
        }
      }

      condition {
        label_name_condition {
          label_name = var.wafv2_web_acl_logging_filter_condition_label_name
        }
      }

      requirement = var.wafv2_web_acl_logging_filter1_requirement
    }

    filter {
      behavior = var.wafv2_web_acl_logging_filter2_behavior

      condition {
        action_condition {
          action = wafv2_web_acl_logging_filter2_action_condition_action
        }
      }

      requirement = var.wafv2_web_acl_logging_filter2_requirement
    }
  }
}
