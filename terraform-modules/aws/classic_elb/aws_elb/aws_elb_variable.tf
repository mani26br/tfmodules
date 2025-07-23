variable "elb_name" {
  type    = string
  default = ""
}

variable "elb_name_prefix" {
  type    = string
  default = null
}

variable "elb_access_logs" {
  type    = any
  default = {}
}

variable "elb_availability_zones" {
  type    = list
  default = []
}

variable "elb_security_groups" {
  type    = list
  default = []
}

variable "elb_subnets" {
  type    = list
  default = []
}

variable "elb_instances" {
  type    = list
  default = []
}

variable "elb_internal" {
  type    = bool
  default = false
}

variable "elb_listener" {
  type    = list(map(string))
  default = []
}

variable "elb_health_check" {
  type    = any
  default = {}
}

variable "elb_cross_zone_load_balancing" {
  type    = bool
  default = true
}

variable "elb_idle_timeout" {
  type    = number
  default = 60
}

variable "elb_connection_draining" {
  type    = bool
  default = false
}

variable "elb_connection_draining_timeout" {
  type    = number
  default = 300
}

variable "elb_tags" {
  type    = map
  default = {}
}
