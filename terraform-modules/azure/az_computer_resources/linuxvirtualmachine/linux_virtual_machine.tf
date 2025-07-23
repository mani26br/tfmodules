resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
  admin_username = var.linux_virtual_machine-admin_username
  location = var.linux_virtual_machine-location
  license_type = var.linux_virtual_machine-license_type
  name = var.linux_virtual_machine-name
  network_interface_ids = var.linux_virtual_machine-network_interface_ids

  dynamic "os_disk" {
    for_each = var.linux_virtual_machine-os_disk

    content {
      caching = lookup(os_disk.value, "caching", null)
      storage_account_type = lookup(os_disk.value, "storage_account_type", null)

      /*
      dynamic "diff_disk_settings" {
        for_each = os_disk.value.diff_disk_settings

        content {
          option = lookup(diff_disk_settings.value, "option", null)
        }
	    }
      */

      disk_encryption_set_id = lookup(os_disk.value, "disk_encryption_set_id", null)
      disk_size_gb = lookup(os_disk.value, "disk_size_gb", null)
      name = lookup(os_disk.value, "name", null)
      write_accelerator_enabled = lookup(os_disk.value, "write_accelerator_enabled", null)
    }
  }

  resource_group_name = var.linux_virtual_machine-resource_group_name
  size = var.linux_virtual_machine-size

  dynamic "additional_capabilities" {
    for_each = var.linux_virtual_machine-additional_capabilities

    content {
      ultra_ssd_enabled = lookup(additional_capabilities.value, "ultra_ssd_enabled", null)
    }
  }

  dynamic "admin_ssh_key" {
    for_each = var.linux_virtual_machine-admin_ssh_key

    content {
      public_key = lookup(admin_ssh_key.value, "public_key", null)
      username = lookup(admin_ssh_key.value, "username", null)
    }
  }

  allow_extension_operations = var.linux_virtual_machine-allow_extension_operations
  availability_set_id = var.linux_virtual_machine-availability_set_id

  dynamic "boot_diagnostics" {
    for_each = var.linux_virtual_machine-boot_diagnostics

    content {
      storage_account_uri = lookup(boot_diagnostics.value, "storage_account_uri", null)
    }
  }

  computer_name = var.linux_virtual_machine-computer_name
  custom_data = var.linux_virtual_machine-custom_data
  dedicated_host_id = var.linux_virtual_machine-dedicated_host_id
  disable_password_authentication = var.linux_virtual_machine-disable_password_authentication
  encryption_at_host_enabled = var.linux_virtual_machine-encryption_at_host_enabled
  eviction_policy = var.linux_virtual_machine-eviction_policy
  extensions_time_budget = var.linux_virtual_machine-extensions_time_budget

  dynamic "identity" {
    for_each = var.linux_virtual_machine-identity

    content {
      type = lookup(identity.value, "type", null)
      ##identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  max_bid_price = var.linux_virtual_machine-max_bid_price

  dynamic "plan" {
    for_each = var.linux_virtual_machine-plan

    content {
      name = lookup(plan.value, "name", null)
      product = lookup(plan.value, "product", null)
      publisher = lookup(plan.value, "publisher", null)
    }
  }

  platform_fault_domain = var.linux_virtual_machine-platform_fault_domain
  priority = var.linux_virtual_machine-priority
  provision_vm_agent = var.linux_virtual_machine-provision_vm_agent
  proximity_placement_group_id = var.linux_virtual_machine-proximity_placement_group_id

  dynamic "secret" {
    for_each = var.linux_virtual_machine-secret

    content {
      dynamic "certificate" {
        for_each = secret.value.certificate

        content {
          url = lookup(certificate.value, "url", null)
        }
	    }

      key_vault_id = lookup(secret.value, "key_vault_id", null)
    }
  }

  source_image_id = var.linux_virtual_machine-source_image_id

  dynamic "source_image_reference" {
    for_each = var.linux_virtual_machine-source_image_reference

    content {
      publisher = lookup(source_image_reference.value, "publisher", null)
      offer = lookup(source_image_reference.value, "offer", null)
      sku = lookup(source_image_reference.value, "sku", null)
      version = lookup(source_image_reference.value, "version", null)
    }
  }

  tags = var.linux_virtual_machine-tags
  virtual_machine_scale_set_id = var.linux_virtual_machine-virtual_machine_scale_set_id
  zone = var.linux_virtual_machine-zone
}
