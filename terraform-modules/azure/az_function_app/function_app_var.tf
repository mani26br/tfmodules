variable "function_app_name" {
  type = string
  default = ""
}

variable "function_app_rg_name" {
  type = string
  default = ""
}

variable "function_app_locaion" {
  type = string
  default = ""
}

variable "function_app_service_plan_id" {
  type = string
  default = ""
}

variable "function_app_settings" {
  type = map
  default = {}
}

variable "function_app_auth_settings" {
  type = any
  default = {}
}

variable "function_app_connection_string" {
  type = any
  default = {}
}

variable "function_app_client_affinity_enabled" {
  type = string
  default = "false"
}

variable "function_app_client_cert_mode" {
  type = string
  default = "Optional"
}

variable "function_app_daily_memory_time_quota" {
  type = string
  default = "0"
}

variable "function_app_enabled" {
  type = string
  default = "false"
}

variable "function_app_enable_builtin_logging" {
  type = string
  default = "true"
}
### To ensure that users can only access your Azure Function App via HTTPS###
variable "function_app_https_only" {
  type = string
  default = "true"
}

variable "function_app_identity" {
  type = any
  default = {}
}

variable "function_app_key_vault_reference_identity_id" {
  type = string
  default = ""
}

variable "function_app_os_type" {
  type = string
  default = ""
}

variable "function_app_site_config" {
  type = any
  default = {}
}

variable "function_app_scm_ip_restriction" {
  type = any
  default = {}
}

variable "function_app_source_control" {
  type = any
  default = {}
}

variable "function_app_storage_account_name" {
  type = string
  default = ""
}

variable "function_app_storage_account_access_key" {
  type = string
  default = ""
}

variable "function_app_version" {
  type = string
  default = "~1"
}

variable "function_app_tags" {
  type = map
  default = {}
}
