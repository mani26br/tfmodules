variable "aks_name" {
  type    = string
  default = ""
}

variable "aks_location" {
  type    = string
  default = ""
}

variable "aks_resource_group_name" {
  type    = string
  default = ""
}

variable "aks_default_node_pool" {
  type    = any
  default = []
}

variable "aks_dns_prefix" {
  type    = string
  default = null
}

variable "aks_automatic_channel_upgrade" {
  type    = string
  default = null
}

variable "aks_addon_profile" {
  type    = any
  default = []
}

variable "aks_api_server_authorized_ip_ranges" {
  type    = list
  default = []
}

variable "aks_auto_scaler_profile" {
  type    = any
  default = []
}

variable "ask_disk_encryption_set_id" {
  type    = string
  default = null
}

variable "aks_identity" {
  type    = any
  default = []
}

variable "aks_kubelet_identity" {
  type    = any
  default = []
}

variable "aks_kubernetes_version" {
  type    = string
  default = null
}

variable "aks_linux_profile" {
  type    = any
  default = []
}

variable "aks_local_account_disabled" {
  type    = bool
  default = null
}

variable "aks_maintenance_window" {
  type    = any
  default = []
}

variable "aks_network_profile" {
  type    = any
  default = []
}

variable "aks_node_resource_group" {
  type    = string
  default = ""
}

variable "aks_private_cluster_enabled" {
  type    = bool
  default = null
}

variable "aks_private_dns_zone_id" {
  type    = string
  default = null
}

variable "aks_private_cluster_public_fqdn_enabled" {
  type    = bool
  default = null
}

variable "aks_role_based_access_control" {
  type    = any
  default = []
}

variable "aks_service_principal" {
  type    = any
  default = []
}

variable "aks_sku_tier" {
  type    = string
  default = ""
}

variable "aks_tags" {
  type    = map
  default = {}
}

variable "aks_windows_profile" {
  type    = any
  default = []
}
