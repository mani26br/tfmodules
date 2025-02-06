variable "lb_name" {
  type = string
  default = ""
}

variable "lb_name_prefix" {
  type = string
  default = null
}

variable "lb_internal" {
  type = bool
  default = false
}

variable "lb_load_balancer_type" {
  type = string
  default = ""
}

variable "lb_security_groups" {
  type = list
  default = []
}

variable "lb_access_logs" {
  type = map
  default = {}
}

variable "lb_subnets" {
  type = list
  default = []
}

variable "lb_subnet_mapping" {
  type = any
  default = {}
}

variable "lb_idle_timeout" {
  type = number
}

variable "lb_enable_deletion_protection" {
  type = bool
  default = false
}

variable "lb_enable_cross_zone_load_balancing" {
  type = bool
  default = false
}

variable "lb_enable_http2" {
  type = bool
  default = true
}

variable "lb_ip_address_type" {
  type = string
  default = ""
}

variable "lb_tags" {
  type = map
  default = {}
}

variable "create_waf_acl" {
  description = "Whether to create AWS WAF Web ACL or not"
  type        = bool
  default     = false
}

variable "lb_arn" {
  description = "ARN of the Application Load Balancer (ALB)"
  type        = string
}

variable "lb_waf_acl_arn" {
  description = "ARN of the AWS WAF Web ACL"
  type        = string
}

