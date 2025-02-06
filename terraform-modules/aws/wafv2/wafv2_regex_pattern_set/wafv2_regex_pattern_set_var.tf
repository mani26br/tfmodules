variable "wafv2_regex_pattern_set_name" {
  type    = string
  default = ""
}

variable "wafv2_regex_pattern_set_description" {
  type    = string
  default = ""
}

variable "wafv2_regex_pattern_set_scope" {
  type    = string
  default = "REGIONAL"
}

variable "wafv2_ip_ip_address_version" {
  type    = string
  default = "IPV4"
}

variable "wafv2_ip_set_addresses" {
  type    = list
  default = null
}

variable "wafv2_regex_string" {
  type    = list(map(any))
  default = []
}

variable "wafv2_ip_set_name_tags" {
  type    = map
  default = {}
}
