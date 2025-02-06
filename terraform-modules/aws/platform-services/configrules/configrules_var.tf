variable "acm_certificate_expiration_check" {
  description = "Time in days before alerting that your ACM cert will expire"
  default     = 30
  type        = number
}

variable "rulepacks_to_include" {
  description = "A list of individual AWS-managed Config Rules to deploy"
  default     = ["Operational-Best-Practices-for-NIST-800-53-rev-4"]
  type        = list(string)
}

variable "rulepacks_to_exclude" {
  description = "A list of individual AWS-managed Config Rules to exclude from  deploy"
  default     = ["Operational-Best-Practices-for-CIS-AWS-v1.4-Level1","Operational-Best-Practices-for-CIS-AWS-v1.4-Level2"]
  type        = list(string)
}

variable "rules_to_include" {
  description = "A list of individual AWS-managed Config Rules to deploy"
  default     = ["dax-encryption-enabled"]
  type        = list(string)
}

variable "rules_to_exclude" {
  description = "A list of individual AWS-managed Config Rules to exclude from deployment"
  default     = ["lambda-concurrency-check"]
  type        = list(string)
}
