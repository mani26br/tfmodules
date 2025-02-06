resource "azurerm_function_app" "function_app" {
  name = var.function_app_name
  resource_group_name = var.function_app_rg_name
  location = var.function_app_locaion
  app_service_plan_id = var.function_app_service_plan_id
  app_settings = var.function_app_settings

  dynamic "auth_settings" {
    for_each = var.function_app_auth_settings

    content {
      enabled = lookup(auth_settings.value, "enabled", null)

      dynamic "active_directory" {
        for_each = lookup(auth_settings.value, "active_directory", {})

        content {
          client_id = lookup(active_directory.value, "client_id", null)
          client_secret = lookup(active_directory.value, "client_secret", null)
          allowed_audiences = lookup(active_directory.value, "allowed_audiences", null)
        }
      }

      additional_login_params = lookup(auth_settings.value, "additional_login_params", null)
      allowed_external_redirect_urls = lookup(auth_settings.value, "allowed_external_redirect_urls", null)
      default_provider = lookup(auth_settings.value, "default_provider", null)

      dynamic "facebook" {
        for_each = lookup(auth_settings.value, "facebook", {})

        content {
          app_id = lookup(facebook.value, "app_id", null)
          app_secret = lookup(facebook.value, "app_secret", null)
          oauth_scopes = lookup(facebook.value, "oauth_scopes", null)
        }
      }

      dynamic "google" {
        for_each = lookup(auth_settings.value, "google", {})

        content {
          client_id = lookup(google.value, "client_id", null)
          client_secret = lookup(google.value, "client_secret", null)
          oauth_scopes = lookup(google.value, "oauth_scopes", null)
        }
      }

      issuer = lookup(auth_settings.value, "issuer", null)

      dynamic "microsoft" {
        for_each = lookup(auth_settings.value, "issuer", {})

        content {
          client_id = lookup(microsoft.value, "client_id", null)
          client_secret = lookup(microsoft.value, "client_secret", null)
          oauth_scopes = lookup(microsoft.value, "oauth_scopes", null)
        }
      }

      runtime_version = lookup(auth_settings.value, "runtime_version", null)
      token_refresh_extension_hours = lookup(auth_settings.value, "token_refresh_extension_hours", null)
      token_store_enabled = lookup(auth_settings.value, "token_store_enabled", null)
      #twitter = lookup(auth_settings.value, "twitter", null)
      unauthenticated_client_action = lookup(auth_settings.value, "unauthenticated_client_action", null)
    }
  }

  dynamic "connection_string" {
    for_each = var.function_app_connection_string

    content {
      name = lookup(connection_string.value, "name", null)
      type = lookup(connection_string.value, "type", null)
      value = lookup(connection_string.value, "value", null)
    }
  }

  #client_affinity_enabled = var.function_app_client_affinity_enabled
  client_cert_mode = var.function_app_client_cert_mode
  daily_memory_time_quota = var.function_app_daily_memory_time_quota
  enabled = var.function_app_enabled
  enable_builtin_logging = var.function_app_enable_builtin_logging
  https_only = var.function_app_https_only

  dynamic "identity" {
    for_each = var.function_app_identity

    content {
      type = lookup(identity.value, "type", null)
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  #key_vault_reference_identity_id = var.function_app_key_vault_reference_identity_id
  os_type = var.function_app_os_type

  dynamic "site_config" {
    for_each = var.function_app_site_config

    content {
      always_on = lookup(site_config.value, "always_on", null)
      app_scale_limit = lookup(site_config.value, "app_scale_limit", null)

      dynamic "cors" {
        for_each = lookup(site_config.value, "cors", {})

        content {
          allowed_origins = lookup(cors.value, "allowed_origins", null)
          support_credentials = lookup(cors.value, "support_credentials", null)
        }
      }
      dotnet_framework_version = lookup(site_config.value, "dotnet_framework_version", null)
      elastic_instance_minimum = lookup(site_config.value, "elastic_instance_minimum", null)
      ftps_state = lookup(site_config.value, "ftps_state", null)
      health_check_path = lookup(site_config.value, "health_check_path", null)
      http2_enabled = lookup(site_config.value, "http2_enabled", null)

      dynamic "ip_restriction" {
        for_each = lookup(site_config.value, "ip_restriction", {})

        content {
          ip_address = lookup(ip_restriction.value, "ip_address", null)
          service_tag = lookup(ip_restriction.value, "service_tag", null)
          virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id", null)
          name = lookup(ip_restriction.value, "name", null)
          priority = lookup(ip_restriction.value, "priority", null)
          action = lookup(ip_restriction.value, "action", null)

          dynamic "headers" {
            for_each = lookup(ip_restriction.value, "headers", {})

            content {
              x_azure_fdid = lookup(headers.value, "x_azure_fdid", null)
              x_fd_health_probe = lookup(headers.value, "x_fd_health_probe", null)
              x_forwarded_for = lookup(headers.value, "x_forwarded_for", null)
              x_forwarded_host = lookup(headers.value, "x_forwarded_host", null)
            }
          }
        }
      }

      java_version = lookup(site_config.value, "java_version", null)
      linux_fx_version = lookup(site_config.value, "linux_fx_version", null)
      min_tls_version = lookup(site_config.value, "min_tls_version", "1.2") ##Added min_tls_version for secure communications
      pre_warmed_instance_count = lookup(site_config.value, "pre_warmed_instance_count", null)
      runtime_scale_monitoring_enabled = lookup(site_config.value, "runtime_scale_monitoring_enabled", null)

      dynamic "scm_ip_restriction" {
        for_each = var.function_app_scm_ip_restriction

        content {
          ip_address = lookup(scm_ip_restriction.value, "ip_address", null)
          service_tag = lookup(scm_ip_restriction.value, "service_tag", null)
          virtual_network_subnet_id = lookup(scm_ip_restriction.value, "virtual_network_subnet_id", null)
          name = lookup(scm_ip_restriction.value, "name", null)
          priority = lookup(scm_ip_restriction.value, "priority", null)
          action = lookup(scm_ip_restriction.value, "action", null)
          dynamic "headers" {
            for_each = lookup(scm_ip_restriction.value, "headers", {})

            content {
              x_azure_fdid = lookup(headers.value, "x_azure_fdid", null)
              x_fd_health_probe = lookup(headers.value, "x_fd_health_probe", null)
              x_forwarded_for = lookup(headers.value, "x_forwarded_for", null)
              x_forwarded_host = lookup(headers.value, "x_forwarded_host", null)
            }
          }
        }
      }

      scm_type = lookup(site_config.value, "scm_type", null)
      scm_use_main_ip_restriction = lookup(site_config.value, "scm_use_main_ip_restriction", null)
      use_32_bit_worker_process = lookup(site_config.value, "use_32_bit_worker_process", null)
      vnet_route_all_enabled = lookup(site_config.value, "vnet_route_all_enabled", null)
      websockets_enabled = lookup(site_config.value, "websockets_enabled", null)
    }
  }

  dynamic "source_control" {
    for_each = var.function_app_source_control

    content {
      repo_url = lookup(source_control.value, "repo_url", null)
      branch = lookup(source_control.value, "branch", null)
      manual_integration = lookup(source_control.value, "manual_integration", null)
      rollback_enabled = lookup(source_control.value, "rollback_enabled", null)
      use_mercurial = lookup(source_control.value, "use_mercurial", null)
    }
  }

  storage_account_name = var.function_app_storage_account_name
  storage_account_access_key = var.function_app_storage_account_access_key
  version = var.function_app_version
  tags = tomap(var.function_app_tags)
}
