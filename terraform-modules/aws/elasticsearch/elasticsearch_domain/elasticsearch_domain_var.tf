variable "elasticsearch_domain_name" {
  description = "Provide the name of the elasticsearch domain"
  type = string
  default = ""
}

variable "elasticsearch_version" {
  description = "Provide the elasticsearch version"
  type = string
  default = ""
}

variable "elasticsearch_instance_type" {
  description = "Provide the instance type"
  type = string
  default = ""
}

variable "elasticsearch_master_type" {
  description = "Provide the master nodes instance type"
  type = string
  default = ""
}

variable "elasticsearch_instance_count" {
  description = "Provide the number of instances"
  type = number
  default = null
}

variable "elasticsearch_dedicated_master" {
  description = "Is domain using dedicated masters"
  type = bool
  default = false
}

variable "elasticsearch_master_count" {
  description = "Provide the number of dedicated masters if any"
  type = number
  default = null
}

variable "elasticsearch_snapshot_start_hour" {
  description = "Provide the start snapshot hour"
  type = number
  default = 23
}

variable "elasticsearch_vpc_options" {
  type = list(map(string))
  default = []
}

variable "elasticsearch_domain_tags" {
   type = map
   default = {}
}

variable "elasticsearch_access_policies" {
  description = "IAM policy document specifying the access policies for the domain"
  type = string
  default = ""
}

variable "elasticsearch_zone_awareness_enabled" {
   type = bool
   default = false
}

variable "elasticsearch_encrypt_at_rest_enabled" {
   type = bool
   default = false
}

variable "elasticsearch_node_to_node_encryption" {
   type = bool
   default = false
}

variable "elasticsearch_availability_zone_count" {
   type = string
   default = ""
}

variable "elasticsearch_ebs_volume_size" {
   type = string
   default = ""
}

variable "elasticsearch_tls_security_policy" {
   type = string
   default = ""
}

variable "elasticsearch_master_user_name" {
   type = string
   default = ""
}

variable "elasticsearch_master_user_password" {
   type = string
   default = ""
}

variable "elasticsearch_enforce_https" {
   type = bool
   default = true
}

variable "elasticsearch_advanced_security_options_enabled" {
   type = bool
   default = true
}

variable "elasticsearch_internal_user_database_enabled" {
   type = bool
   default = true
}

variable "elasticsearch_index_slow_logs_enabled" {
   type = bool
   default = false
}

variable "elasticsearch_search_slow_logs_enabled" {
   type = bool
   default = false
}

variable "elasticsearch_es_application_logs_enabled" {
   type = bool
   default = false
}

variable "elasticsearch_audit_logs_enabled" {
   type = bool
   default = false
}

variable "elasticsearch_aws_cloudwatch_log_group_arn" {
   type = string
   default = ""
}
