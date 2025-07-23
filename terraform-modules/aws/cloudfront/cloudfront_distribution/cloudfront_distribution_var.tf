variable "cf_aliases" {
  type    = list
  default = []
}

variable "cf_comment" {
  type    = string
  default = null
}

variable "cf_custom_error_response" {
  type    = any
  default = {}
}

variable "cf_default_cache_behavior" {
  type    = any
  default = {}
}

variable "cf_default_root_object" {
  type    = string
  default = null
}

variable "cf_enabled" {
  type    = bool
  default = false
}

variable "cf_is_ipv6_enabled" {
  type    = bool
  default = false
}

variable "cf_http_version" {
  type    = string
  default = null
}

variable "cf_logging_config" {
  type    = any
  default = {}
}

variable "cf_ordered_cache_behavior" {
  type    = any
  default = {}
}

variable "cf_origin" {
  type    = any
  default = {}
}

variable "cf_origin_group" {
  type    = any
  default = {}
}

variable "cf_price_class" {
  type    = string
  default = null
}

variable "cf_restrictions" {
  type    = any
  default = {}
}

variable "cf_tags" {
  type    = any
  default = null
}

variable "cf_viewer_certificate" {
  type    = any
  default = {}
}

variable "cf_web_acl_id" {
  type    = string
  default = null
}

variable "cf_retain_on_delete" {
  type    = string
  default = null
}

variable "cf_wait_for_deployment" {
  type    = string
  default = null
}
