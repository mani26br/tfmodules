#Note: To use aks container service we need to enable "Microsoft.ContainerService/DisableLocalAccountsPreview" endpoint to snet

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.aks_location
  resource_group_name = var.aks_resource_group_name

  dynamic "default_node_pool" {
    for_each = var.aks_default_node_pool

    content {
      name                   = lookup(default_node_pool.value, "name", null)
      vm_size                = lookup(default_node_pool.value, "vm_size", null)
      availability_zones     = lookup(default_node_pool.value, "availability_zones", [])
      enable_auto_scaling    = lookup(default_node_pool.value, "enable_auto_scaling", null)
      max_count              = lookup(default_node_pool.value, "max_count", null)
      min_count              = lookup(default_node_pool.value, "min_count", null)
      node_count             = lookup(default_node_pool.value, "node_count", null)
      enable_host_encryption = lookup(default_node_pool.value, "enable_host_encryption", null)
      enable_node_public_ip  = lookup(default_node_pool.value, "enable_node_public_ip", null)

      dynamic "kubelet_config" {
        for_each = lookup(default_node_pool.value, "kubelet_config", [])

        content {
          allowed_unsafe_sysctls    = lookup(kubelet_config.value, "allowed_unsafe_sysctls", null)
          container_log_max_line    = lookup(kubelet_config.value, "container_log_max_line", null)
          container_log_max_size_mb = lookup(kubelet_config.value, "container_log_max_size_mb", null)
          cpu_cfs_quota_enabled     = lookup(kubelet_config.value, "cpu_cfs_quota_enabled", null)
          cpu_cfs_quota_period      = lookup(kubelet_config.value, "cpu_cfs_quota_period", null)
          cpu_manager_policy        = lookup(kubelet_config.value, "cpu_manager_policy", null)
          image_gc_high_threshold   = lookup(kubelet_config.value, "image_gc_high_threshold", null)
          image_gc_low_threshold    = lookup(kubelet_config.value, "image_gc_low_threshold", null)
          pod_max_pid               = lookup(kubelet_config.value, "pod_max_pid", null)
          topology_manager_policy   = lookup(kubelet_config.value, "topology_manager_policy", null)
        }
      }

      dynamic "linux_os_config" {
        for_each = lookup(default_node_pool.value, "linux_os_config", [])

        content {
          swap_file_size_mb = lookup(linux_os_config.value, "swap_file_size_mb", null)

          dynamic "sysctl_config" {
            for_each = lookup(linux_os_config.value, "sysctl_config", null)

            content {
              fs_aio_max_nr                      = lookup(sysctl_config.value, "fs_aio_max_nr", null)
              fs_file_max                        = lookup(sysctl_config.value, "fs_file_max", null)
              fs_inotify_max_user_watches        = lookup(sysctl_config.value, "fs_inotify_max_user_watches", null)
              fs_nr_open                         = lookup(sysctl_config.value, "fs_nr_open", null)
              kernel_threads_max                 = lookup(sysctl_config.value, "kernel_threads_max", null)
              net_core_netdev_max_backlog        = lookup(sysctl_config.value, "net_core_netdev_max_backlog", null)
              net_core_optmem_max                = lookup(sysctl_config.value, "net_core_optmem_max", null)
              net_core_rmem_default              = lookup(sysctl_config.value, "net_core_rmem_default", null)
              net_core_rmem_max                  = lookup(sysctl_config.value, "net_core_rmem_max", null)
              net_core_somaxconn                 = lookup(sysctl_config.value, "net_core_somaxconn", null)
              net_core_wmem_default              = lookup(sysctl_config.value, "net_core_wmem_default", null)
              net_core_wmem_max                  = lookup(sysctl_config.value, "net_core_wmem_max", null)
              net_ipv4_ip_local_port_range_max   = lookup(sysctl_config.value, "net_ipv4_ip_local_port_range_max", null)
              net_ipv4_ip_local_port_range_min   = lookup(sysctl_config.value, "net_ipv4_ip_local_port_range_min", null)
              net_ipv4_neigh_default_gc_thresh1  = lookup(sysctl_config.value, "net_ipv4_neigh_default_gc_thresh1", null)
              net_ipv4_neigh_default_gc_thresh2  = lookup(sysctl_config.value, "net_ipv4_neigh_default_gc_thresh2", null)
              net_ipv4_neigh_default_gc_thresh3  = lookup(sysctl_config.value, "net_ipv4_neigh_default_gc_thresh3", null)
              net_ipv4_tcp_fin_timeout           = lookup(sysctl_config.value, "net_ipv4_tcp_fin_timeout", null)
              net_ipv4_tcp_keepalive_intvl       = lookup(sysctl_config.value, "net_ipv4_tcp_keepalive_intvl", null)
              net_ipv4_tcp_keepalive_probes      = lookup(sysctl_config.value, "net_ipv4_tcp_keepalive_probes", null)
              net_ipv4_tcp_keepalive_time        = lookup(sysctl_config.value, "net_ipv4_tcp_keepalive_time", null)
              net_ipv4_tcp_max_syn_backlog       = lookup(sysctl_config.value, "net_ipv4_tcp_max_syn_backlog", null)
              net_ipv4_tcp_max_tw_buckets        = lookup(sysctl_config.value, "net_ipv4_tcp_max_tw_buckets", null)
              net_ipv4_tcp_tw_reuse              = lookup(sysctl_config.value, "net_ipv4_tcp_tw_reuse", null)
              net_netfilter_nf_conntrack_buckets = lookup(sysctl_config.value, "net_netfilter_nf_conntrack_buckets", null)
              net_netfilter_nf_conntrack_max     = lookup(sysctl_config.value, "net_netfilter_nf_conntrack_max", null)
              vm_max_tomap_count                   = lookup(sysctl_config.value, "vm_max_tomap_count", null)
              vm_swappiness                      = lookup(sysctl_config.value, "vm_swappiness", null)
              vm_vfs_cache_pressure              = lookup(sysctl_config.value, "vm_vfs_cache_pressure", null)
            }
          }

          transparent_huge_page_defrag  = lookup(linux_os_config.value, "transparent_huge_page_defrag", null)
          transparent_huge_page_enabled = lookup(linux_os_config.value, "transparent_huge_page_enabled", null)
        }
      }

      fips_enabled                 = lookup(default_node_pool.value, "fips_enabled", null)
      kubelet_disk_type            = lookup(default_node_pool.value, "kubelet_disk_type", null)
      max_pods                     = lookup(default_node_pool.value, "max_pods", null)
      node_public_ip_prefix_id     = lookup(default_node_pool.value, "node_public_ip_prefix_id", null)
      node_labels                  = lookup(default_node_pool.value, "node_labels", null)
      only_critical_addons_enabled = lookup(default_node_pool.value, "only_critical_addons_enabled", null)
      orchestrator_version         = lookup(default_node_pool.value, "orchestrator_version", null)
      os_disk_size_gb              = lookup(default_node_pool.value, "os_disk_size_gb", null)
      os_disk_type                 = lookup(default_node_pool.value, "os_disk_type", null)
      os_sku                       = lookup(default_node_pool.value, "os_sku", null)
      pod_subnet_id                = lookup(default_node_pool.value, "pod_subnet_id", null)
      type                         = lookup(default_node_pool.value, "type", null)
      tags                         = lookup(default_node_pool.value, "tags", null)
      ultra_ssd_enabled            = lookup(default_node_pool.value, "ultra_ssd_enabled", null)

      dynamic "upgrade_settings" {
        for_each = lookup(default_node_pool.value, "upgrade_settings", [])

        content {
          max_surge = lookup(upgrade_settings.value, "max_surge", null)
        }
      }

      vnet_subnet_id = lookup(default_node_pool.value, "vnet_subnet_id", null)
    }
  }

  dns_prefix                = var.aks_dns_prefix
  automatic_channel_upgrade = var.aks_automatic_channel_upgrade

  dynamic "addon_profile" {
    for_each = var.aks_addon_profile

    content {

      dynamic "aci_connector_linux" {
        for_each = lookup(addon_profile.value, "aci_connector_linux", [])

        content {
          enabled     = lookup(aci_connector_linux.value, "enabled", false)
          subnet_name = lookup(aci_connector_linux.value, "subnet_name", null)
        }
      }

      dynamic "azure_policy" {
        for_each = lookup(addon_profile.value, "azure_policy", [])

        content {
          enabled = lookup(azure_policy.value, "enabled", false)
        }
      }

      dynamic "http_application_routing" {
        for_each = lookup(addon_profile.value, "http_application_routing", [])

        content {
          enabled = lookup(http_application_routing.value, "enabled", false)
        }
      }

      dynamic "kube_dashboard" {
        for_each = lookup(addon_profile.value, "kube_dashboard", [])

        content {
          enabled = lookup(kube_dashboard.value, "enabled", false)
        }
      }

      dynamic "oms_agent" {
        for_each = lookup(addon_profile.value, "oms_agent", [])

        content {
          enabled                    = lookup(oms_agent.value, "enabled", false)
          log_analytics_workspace_id = lookup(oms_agent.value, "log_analytics_workspace_id", null)
        }
      }

      dynamic "ingress_application_gateway" {
        for_each = lookup(addon_profile.value, "ingress_application_gateway", [])

        content {
          enabled      = lookup(ingress_application_gateway.value, "enabled", false)
          gateway_id   = lookup(ingress_application_gateway.value, "gateway_id", null)
          gateway_name = lookup(ingress_application_gateway.value, "gateway_name", null)
          subnet_cidr  = lookup(ingress_application_gateway.value, "subnet_cidr", null)
          subnet_id    = lookup(ingress_application_gateway.value, "subnet_id", null)
        }
      }
    }
  }

  api_server_authorized_ip_ranges = var.aks_api_server_authorized_ip_ranges

  dynamic "auto_scaler_profile" {
    for_each = var.aks_auto_scaler_profile

    content {
      balance_similar_node_groups      = lookup(auto_scaler_profile.value, "balance_similar_node_groups", "false")
      expander                         = lookup(auto_scaler_profile.value, "expander", "random")
      max_graceful_termination_sec     = lookup(auto_scaler_profile.value, "max_graceful_termination_sec", "600")
      max_node_provisioning_time       = lookup(auto_scaler_profile.value, "max_node_provisioning_time", "15m")
      max_unready_nodes                = lookup(auto_scaler_profile.value, "max_unready_nodes", "3")
      max_unready_percentage           = lookup(auto_scaler_profile.value, "max_unready_percentage", "45")
      new_pod_scale_up_delay           = lookup(auto_scaler_profile.value, "new_pod_scale_up_delay", "10s")
      scale_down_delay_after_add       = lookup(auto_scaler_profile.value, "scale_down_delay_after_add", "10m")
      scale_down_delay_after_delete    = lookup(auto_scaler_profile.value, "scale_down_delay_after_delete", null)
      scale_down_delay_after_failure   = lookup(auto_scaler_profile.value, "scale_down_delay_after_failure", "3m")
      scan_interval                    = lookup(auto_scaler_profile.value, "scan_interval", "10s")
      scale_down_unneeded              = lookup(auto_scaler_profile.value, "scale_down_unneeded", "10m")
      scale_down_unready               = lookup(auto_scaler_profile.value, "scale_down_unready", "20m")
      scale_down_utilization_threshold = lookup(auto_scaler_profile.value, "scale_down_utilization_threshold", "0.5")
      empty_bulk_delete_max            = lookup(auto_scaler_profile.value, "empty_bulk_delete_max", "10")
      skip_nodes_with_local_storage    = lookup(auto_scaler_profile.value, "skip_nodes_with_local_storage", "true")
      skip_nodes_with_system_pods      = lookup(auto_scaler_profile.value, "skip_nodes_with_system_pods", "true")
    }
  }

  disk_encryption_set_id = var.ask_disk_encryption_set_id

  dynamic "identity" {
    for_each = var.aks_identity

    content {
      type                      = lookup(identity.value, "type", null)
      user_assigned_identity_id = lookup(identity.value, "user_assigned_identity_id", null)
    }
  }

  dynamic "kubelet_identity" {
    for_each = var.aks_kubelet_identity

    content {
      client_id                 = lookup(kubelet_identity.value, "client_id", null)
      object_id                 = lookup(kubelet_identity.value, "object_id", null)
      user_assigned_identity_id = lookup(kubelet_identity.value, "user_assigned_identity_id", null)
    }
  }

  kubernetes_version = var.aks_kubernetes_version

  dynamic "linux_profile" {
    for_each = var.aks_linux_profile

    content {
      admin_username = lookup(linux_profile.value, "admin_username", null)

      dynamic "ssh_key" {
        for_each = lookup(linux_profile.value, "ssh_key", [])

        content {
          key_data = lookup(ssh_key.value, "key_data", null)
        }
      }
    }
  }

  local_account_disabled = var.aks_local_account_disabled

  dynamic "maintenance_window" {
    for_each = var.aks_maintenance_window

    content {

      dynamic "allowed" {
        for_each = lookup(maintenance_window.value, "allowed", [])

        content {
          day   = lookup(allowed.value, "day", null)
          hours = lookup(allowed.value, "hours", null)
        }
      }

      dynamic "not_allowed" {
        for_each = lookup(maintenance_window.value, "not_allowed", [])

        content {
          end   = lookup(not_allowed.value, "day", null)
          start = lookup(not_allowed.value, "hours", null)
        }
      }
    }
  }

  dynamic "network_profile" {
    for_each = var.aks_network_profile

    content {
      network_plugin     = lookup(network_profile.value, "network_plugin", null)
      network_mode       = lookup(network_profile.value, "network_mode", null)
      network_policy     = lookup(network_profile.value, "network_policy", null)
      dns_service_ip     = lookup(network_profile.value, "dns_service_ip", null)
      docker_bridge_cidr = lookup(network_profile.value, "docker_bridge_cidr", null)
      outbound_type      = lookup(network_profile.value, "outbound_type", null)
      pod_cidr           = lookup(network_profile.value, "pod_cidr", null)
      service_cidr       = lookup(network_profile.value, "service_cidr", null)
      load_balancer_sku  = lookup(network_profile.value, "load_balancer_sku", null)

      dynamic "load_balancer_profile" {
        for_each = lookup(network_profile.value, "load_balancer_profile", [])

        content {
          outbound_ports_allocated  = lookup(load_balancer_profile.value, "outbound_ports_allocated", null)
          idle_timeout_in_minutes   = lookup(load_balancer_profile.value, "idle_timeout_in_minutes", null)
          managed_outbound_ip_count = lookup(load_balancer_profile.value, "managed_outbound_ip_count", null)
          outbound_ip_prefix_ids    = lookup(load_balancer_profile.value, "outbound_ip_prefix_ids", null)
          outbound_ip_address_ids   = lookup(load_balancer_profile.value, "outbound_ip_address_ids", null)
        }
      }
    }
  }

  node_resource_group                 = var.aks_node_resource_group
  private_cluster_enabled             = var.aks_private_cluster_enabled
  private_dns_zone_id                 = var.aks_private_dns_zone_id
  private_cluster_public_fqdn_enabled = var.aks_private_cluster_public_fqdn_enabled

  dynamic "role_based_access_control" {
    for_each = var.aks_role_based_access_control

    content {

      dynamic "azure_active_directory" {
        for_each = lookup(role_based_access_control.value, "azure_active_directory", [])

        content {
          managed                = lookup(azure_active_directory.value, "managed", null)
          tenant_id              = lookup(azure_active_directory.value, "tenant_id", null)
          admin_group_object_ids = lookup(azure_active_directory.value, "admin_group_object_ids", null)
          azure_rbac_enabled     = lookup(azure_active_directory.value, "azure_rbac_enabled", null)
          client_app_id          = lookup(azure_active_directory.value, "client_app_id", null)
          server_app_id          = lookup(azure_active_directory.value, "server_app_id", null)
          server_app_secret      = lookup(azure_active_directory.value, "server_app_secret", null)
        }
      }

      enabled = lookup(role_based_access_control.value, "enabled", null)
    }
  }

  dynamic "service_principal" {
    for_each = var.aks_service_principal

    content {
      client_id     = lookup(service_principal.value, "client_id", null)
      client_secret = lookup(service_principal.value, "client_secret", null)
    }
  }

  sku_tier = var.aks_sku_tier
  tags     = var.aks_tags

  dynamic "windows_profile" {
    for_each = var.aks_windows_profile

    content {
      admin_username = lookup(windows_profile.value, "admin_username", null)
      admin_password = lookup(windows_profile.value, "admin_password", null)
      license        = lookup(windows_profile.value, "license", null)
    }
  }

}
