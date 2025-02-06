variable "linux_virtual_machine-admin_username" {
  description = "Please provide Linux Virtual Machine's Admin Username (Required)"
  type = string
  default = null
}

variable "linux_virtual_machine-location" {
  description = "Please provide Linux Virtual Machine's Location (Required)"
  type = string
  default = null
}

variable "linux_virtual_machine-license_type" {
  description = "Please provide Linux Virtual Machine's License Type (Optional)"
  type = string
  default = null
}

variable "linux_virtual_machine-name" {
  description = "Please provide Linux Virtual Machine's Name (Required)"
  type = string
  default = null
}

variable "linux_virtual_machine-network_interface_ids" {
  description = "Please provide Linux Virtual Machine's Network Interface Ids (Required)"
  type = list(string)
  default = []
}

variable "linux_virtual_machine-os_disk" {
  description = "Please provide Linux Virtual Machine's OS Disk (Required)"
  type = list(map(string))
  default = []
}

variable "linux_virtual_machine-resource_group_name" {
  description = "Please provide Linux Virtual Machine's Resource Group Name (Required)"
  type = string
  default = null
}

variable "linux_virtual_machine-size" {
  description = "Please provide Linux Virtual Machine's VM Size (Required)"
  type = string
  default = null
}

variable "linux_virtual_machine-additional_capabilities" {
  description = "Please provide Linux Virtual Machine's Additional Capabilities (Optional)"
  type = list(map(string))
  default = []
}

variable "linux_virtual_machine-admin_ssh_key" {
  description = "Please provide Linux Virtual Machine's Admin SSH Key (Optional)"
  type = list(map(string))
  default = []
}

variable "linux_virtual_machine-allow_extension_operations" {
  description = "Please provide Linux Virtual Machine's Allow Extension Operations (Optional)"
  type = bool
  default = true
}

variable "linux_virtual_machine-availability_set_id" {
  description = "Please provide Linux Virtual Machine's Availability Set ID (Optional)"
  type = string
  default = null
}

variable "linux_virtual_machine-boot_diagnostics" {
  description = "Please provide Linux Virtual Machine's Boot Diagnostics (Optional)"
  type = list(map(string))
  default = []
}

variable "linux_virtual_machine-computer_name" {
  description = "Please provide Linux Virtual Machine's Computer Name (Optional)"
  type = string
  default = null
}

variable "linux_virtual_machine-custom_data" {
  description = "Please provide Linux Virtual Machine's Custom Data (Optional)"
  type = string
  default = null
}

variable "linux_virtual_machine-dedicated_host_id" {
  description = "Please provide Linux Virtual Machine's Dedicated Host ID (Optional)"
  type = string
  default = null
}

variable "linux_virtual_machine-disable_password_authentication" {
  description = "Please provide Linux Virtual Machine's Disabled Password Authentication (Optional)"
  type = bool
  default = true
}

variable "linux_virtual_machine-encryption_at_host_enabled" {
  description = "Please provide Linux Virtual Machine's Encryption At Host Enabled (Optional)"
  type = bool
  default = false
}

variable "linux_virtual_machine-eviction_policy" {
  description = "Please provide Linux Virtual Machine's Eviction Policy (Optional)"
  type = string
  default = null
}

variable "linux_virtual_machine-extensions_time_budget" {
  description = "Please provide Linux Virtual Machine's Extensions Time Budget (Optional)"
  type = string
  default = null
}

variable "linux_virtual_machine-identity" {
  description = "Please provide Linux Virtual Machine's Identity (Optional)"
  type = list(map(string))
  default = []
}

variable "linux_virtual_machine-max_bid_price" {
  description = "Please provide Linux Virtual Machine's Max Bid Price (Optional)"
  type = number
  default = -1
}

variable "linux_virtual_machine-plan" {
  description = "Please provide Linux Virtual Machine's Plan (Optional)"
  type = list(map(string))
  default = []
}

variable "linux_virtual_machine-platform_fault_domain" {
  description = "Please provide Linux Virtual Machine's Platform Fault Domain (Optional)"
  type = number
  default = null
}

variable "linux_virtual_machine-priority" {
  description = "Please provide Linux Virtual Machine's Priority (Optional)"
  type = string
  default = "Regular"
}

variable "linux_virtual_machine-provision_vm_agent" {
  description = "Please provide Linux Virtual Machine's Provision VM Agent (Optional))"
  type = bool
  default = true
}

variable "linux_virtual_machine-proximity_placement_group_id" {
  description = "Please provide Linux Virtual Machine's Proximity Placement Group ID (Optional)"
  type = string
  default = null
}

variable "linux_virtual_machine-secret" {
  description = "Please provide Linux Virtual Machine's Secret (Optional)"
  type = list(map(string))
  default = []
}

variable "linux_virtual_machine-source_image_id" {
  description = "Please provide Linux Virtual Machine's Source Image ID (Optional)"
  type = string
  default = null
}

variable "linux_virtual_machine-source_image_reference" {
  description = "Please provide Linux Virtual Machine's Source Image Reference (Optional)"
  type = list(map(string))
  default = []
}

variable "linux_virtual_machine-tags" {
  description = "Please provide Linux Virtual Machine's Tags (Optional)"
  type = map
  default = {}
}

variable "linux_virtual_machine-virtual_machine_scale_set_id" {
  description = "Please provide Linux Virtual Machine's Virtual Machine Scale Set ID (Optional)"
  type = string
  default = null
}

variable "linux_virtual_machine-zone" {
  description = "Please provide Linux Virtual Machine's Zone (Optional)"
  type = string
  default = null
}
