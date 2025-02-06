#The ARN (Amazon Resource Name) of the Route53 Health Check resource which will be associated to the protected resource.
variable "shield_protection_health_check_association_arn" {
  type    = string
  default = ""
}
#The ID of the protected resource.
variable "shield_protection_health_check_association_id" {
  type    = string
  default = ""
}
