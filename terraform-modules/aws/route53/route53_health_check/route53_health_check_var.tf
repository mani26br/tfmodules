#The fully qualified domain name of the endpoint to be checked.
variable "route53_health_check_fqdn" {
  type    = string
  default = ""
}
#The port of the endpoint to be checked.
variable "route53_health_check_port" {
  type    = number
  default = null
}
#The protocol to use when performing health checks. Valid values are HTTP, HTTPS, HTTP_STR_MATCH, HTTPS_STR_MATCH, TCP, CALCULATED, CLOUDWATCH_METRIC and RECOVERY_CONTROL.
variable "route53_health_check_type" {
  type    = string
  default = ""
}
#The path that you want Amazon Route 53 to request when performing health checks.
variable "route53_health_check_resource_path" {
  type    = string
  default = ""
}
#The number of consecutive health checks that an endpoint must pass or fail.
variable "route53_health_check_failure_threshold" {
  type    = string
  default = ""
}
#The number of seconds between the time that Amazon Route 53 gets a response from your endpoint and the time that it sends the next health-check request.
variable "route53_health_check_request_interval" {
  type    = string
  default = ""
}
#A map of tag comment to assign to the health check.
variable "route53_health_check_comment" {
  type    = string
  default = ""
}
#A map of tags to assign to the health check.
variable "route53_health_check_tags" {
  type    = any
  default = null
}



