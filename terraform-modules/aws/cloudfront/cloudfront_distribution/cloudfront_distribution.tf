resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  aliases = var.cf_aliases
  comment = var.cf_comment

  dynamic "custom_error_response" {
    for_each = var.cf_custom_error_response

    content {
      error_caching_min_ttl = lookup(custom_error_response.value, "error_caching_min_ttl", null)
      error_code = lookup(custom_error_response.value, "error_code", null)
      response_code = lookup(custom_error_response.value, "response_code", null)
      response_page_path = lookup(custom_error_response.value, "response_page_path", null)
    }
  }

  dynamic "default_cache_behavior" {
    for_each = var.cf_default_cache_behavior

    content {
      allowed_methods = lookup(default_cache_behavior.value, "allowed_methods", null)
      cached_methods = lookup(default_cache_behavior.value, "cached_methods", null)
      cache_policy_id = lookup(default_cache_behavior.value, "cache_policy_id", null)
      compress = lookup(default_cache_behavior.value, "compress", null)
      default_ttl = lookup(default_cache_behavior.value, "default_ttl", null)
      field_level_encryption_id = lookup(default_cache_behavior.value, "field_level_encryption_id", null)

      dynamic "forwarded_values" {
        for_each = lookup(default_cache_behavior.value, "forwarded_values", [])

        content {

          dynamic "cookies" {
            for_each = lookup(forwarded_values.value, "cookies", [])

            content {
              forward = lookup(cookies.value, "forward", null)
              whitelisted_names = lookup(cookies.value, "whitelisted_names", null)
            }
          }
          headers = lookup(forwarded_values.value, "headers", null)
          query_string = lookup(forwarded_values.value, "query_string", null)
          query_string_cache_keys = lookup(forwarded_values.value, "query_string_cache_keys", null)
        }
      }

      dynamic "lambda_function_association" {
        for_each = lookup(default_cache_behavior.value, "lambda_function_association", [])

        content {
          event_type = lookup(lambda_function_association.value, "event_type", null)
          lambda_arn = lookup(lambda_function_association.value, "lambda_arn", null)
          include_body = lookup(lambda_function_association.value, "include_body", null)
        }
      }

      max_ttl = lookup(default_cache_behavior.value, "max_ttl", null)
      min_ttl = lookup(default_cache_behavior.value, "min_ttl", null)
      origin_request_policy_id = lookup(default_cache_behavior.value, "origin_request_policy_id", null)
      realtime_log_config_arn = lookup(default_cache_behavior.value, "realtime_log_config_arn", null)
      smooth_streaming = lookup(default_cache_behavior.value, "smooth_streaming", null)
      target_origin_id = lookup(default_cache_behavior.value, "target_origin_id", null)
      trusted_signers = lookup(default_cache_behavior.value, "trusted_signers", null)
      viewer_protocol_policy = lookup(default_cache_behavior.value, "viewer_protocol_policy", null)
    }
  }

  default_root_object = var.cf_default_root_object
  enabled = var.cf_enabled
  is_ipv6_enabled = var.cf_is_ipv6_enabled
  http_version = var.cf_http_version

  dynamic "logging_config" {
    for_each = var.cf_logging_config

    content {
      bucket = lookup(logging_config.value, "bucket", null)
      include_cookies = lookup(logging_config.value, "include_cookies", null)
      prefix = lookup(logging_config.value, "prefix", null)
    }
  }

  dynamic "ordered_cache_behavior" {
    for_each = var.cf_ordered_cache_behavior

    content {
      allowed_methods = lookup(ordered_cache_behavior.value, "allowed_methods", null)
      cached_methods = lookup(ordered_cache_behavior.value, "cached_methods", null)
      cache_policy_id = lookup(ordered_cache_behavior.value, "cache_policy_id", null)
      compress = lookup(ordered_cache_behavior.value, "compress", null)
      default_ttl = lookup(ordered_cache_behavior.value, "default_ttl", null)
      field_level_encryption_id = lookup(ordered_cache_behavior.value, "field_level_encryption_id", null)

      dynamic "forwarded_values" {
        for_each = lookup(ordered_cache_behavior.value, "forwarded_values", [])

        content {

          dynamic "cookies" {
            for_each = lookup(forwarded_values.value, "cookies", [])

            content {
              forward = lookup(cookies.value, "forward", null)
              whitelisted_names = lookup(cookies.value, "whitelisted_names", null)
            }
          }

          headers = lookup(forwarded_values.value, "headers", null)
          query_string = lookup(forwarded_values.value, "query_string", null)
          query_string_cache_keys = lookup(forwarded_values.value, "query_string_cache_keys", null)
        }
      }

      dynamic "lambda_function_association" {
        for_each = lookup(ordered_cache_behavior.value, "lambda_function_association", [])

        content {
          event_type = lookup(lambda_function_association.value, "event_type", null)
          lambda_arn = lookup(lambda_function_association.value, "lambda_arn", null)
          include_body = lookup(lambda_function_association.value, "include_body", null)
        }
      }

      max_ttl = lookup(ordered_cache_behavior.value, "max_ttl", null)
      min_ttl = lookup(ordered_cache_behavior.value, "min_ttl", null)
      origin_request_policy_id = lookup(ordered_cache_behavior.value, "origin_request_policy_id", null)
      path_pattern = lookup(ordered_cache_behavior.value, "path_pattern", null)
      realtime_log_config_arn = lookup(ordered_cache_behavior.value, "realtime_log_config_arn", null)
      smooth_streaming = lookup(ordered_cache_behavior.value, "smooth_streaming", null)
      target_origin_id = lookup(ordered_cache_behavior.value, "target_origin_id", null)
      trusted_signers = lookup(ordered_cache_behavior.value, "trusted_signers", null)
      viewer_protocol_policy = lookup(ordered_cache_behavior.value, "viewer_protocol_policy", null)
    }
  }

  dynamic "origin" {
    for_each = var.cf_origin

    content {

      dynamic "custom_origin_config" {
        for_each = lookup(origin.value, "custom_origin_config", [])

        content {
          http_port = lookup(custom_origin_config.value, "http_port", "")
          https_port = lookup(custom_origin_config.value, "https_port", "")
          origin_protocol_policy = lookup(custom_origin_config.value, "origin_protocol_policy", "")
          origin_ssl_protocols = lookup(custom_origin_config.value, "origin_ssl_protocols", "")
          origin_keepalive_timeout = lookup(custom_origin_config.value, "origin_keepalive_timeout", null)
          origin_read_timeout = lookup(custom_origin_config.value, "origin_read_timeout", null)
        }
      }

      domain_name = origin.value.domain_name

      dynamic "custom_header" {
        for_each = lookup(origin.value, "custom_header", [])

        content {
          name = lookup(custom_header.value, "name", null)
          value = lookup(custom_header.value, "value", null)
        }
      }
      origin_id = lookup(origin.value, "origin_id", null)
      origin_path = lookup(origin.value, "origin_path", "")

      dynamic "s3_origin_config" {
        for_each = lookup(origin.value, "s3_origin_config", [])

        content {
          origin_access_identity = lookup(s3_origin_config.value, "origin_access_identity", "")
        }
      }
    }
  }

  dynamic "origin_group" {
    for_each = var.cf_origin_group

    content {
      origin_id = lookup(origin_group.value, "origin_id", null)

      dynamic "failover_criteria" {
        for_each = lookup(origin_group.value, "failover_criteria", null)

        content {
          status_codes = lookup(failover_criteria.value, "status_codes", null)
        }
      }

      dynamic "member" {
        for_each = lookup(origin_group.value, "member", null)

        content {
          origin_id = lookup(member.value, "origin_id", null)
        }
      }
    }
  }

  price_class = var.cf_price_class

  restrictions {
    dynamic "geo_restriction" {
      for_each = [var.cf_restrictions]

      content {
        locations = lookup(geo_restriction.value, "locations", null)
        restriction_type = lookup(geo_restriction.value, "restriction_type", "none")
      }
    }
  }

  tags = merge(map(
  "comment", var.cf_comment,
  ), var.cf_tags)

  dynamic "viewer_certificate" {
    for_each = var.cf_viewer_certificate

    content {
      acm_certificate_arn = lookup(viewer_certificate.value, "acm_certificate_arn", null)
      cloudfront_default_certificate = lookup(viewer_certificate.value, "cloudfront_default_certificate", null)
      iam_certificate_id = lookup(viewer_certificate.value, "iam_certificate_id", null)
      minimum_protocol_version = lookup(viewer_certificate.value, "minimum_protocol_version", null)
      ssl_support_method = lookup(viewer_certificate.value, "ssl_support_method", null)
    }
  }

  web_acl_id = var.cf_web_acl_id
  retain_on_delete = var.cf_retain_on_delete
  wait_for_deployment = var.cf_wait_for_deployment

}
