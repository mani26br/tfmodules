variable "enable_default_standards" {
  description = "Flag to indicate whether default standards should be enabled"
  type        = bool
  default     = true
}

variable "security_hub_enabled" {
  type        = bool
  default     = true
  description = "To Enable seucirty-hub in aws account"
}

variable "enable" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
}

