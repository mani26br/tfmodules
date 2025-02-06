variable "zone_id" {
  type = string
  description = "The zone id of the hosted zone"
  default = ""
}

variable "logs_cloudwatch_retention" {
  type    = string
  default = "90"
}

variable "route53_zone_name" {
  type    = string
  description = "The Route53 hosted zone name"
  default = ""
}

variable "environment" {
  type    = string
  default = ""
}

variable "retention_period" {
  type    = number
  default = 0
}

variable "query_logs" {
  type = string
  default = "DNS_Query_logs"
}

variable "cloudwatch_log_tags" {
  type    = map(any)
  default = {}
}
