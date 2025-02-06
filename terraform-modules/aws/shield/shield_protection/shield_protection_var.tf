#name for the Protection we are creating
variable "shield_protection_name" {
  type    = string
  default = ""
}

#The ARN (Amazon Resource Name) of the resource to be protected
variable "shield_protection_arn" {
  type    = string
  default = ""
}

#Key-value map of resource tags. If configured with a provider
variable "shield_protection_tags" {
  type    = any
  default = null
}

# Comments for the shield protected
variable "shield_protection_comment" {
  type    = string
  default = ""
}
