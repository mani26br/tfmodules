variable "cert_domain_name" {
  type    = string
  default = null
}

variable "cert_subject_alternative_names" {
  type    = list
  default = []
}

variable "cert_validation_method" {
  type    = string
  default = null
}

variable "cert_options" {
  type    = any
  default = {}
}

variable "cert_private_key" {
  type    = string
  default = null
}

variable "cert_certificate_body" {
  type    = string
  default = null
}

variable "cert_certificate_chain" {
  type    = string
  default = null
}

variable "cert_certificate_authority_arn" {
  type    = string
  default = null
}

variable "cert_tags" {
  type    = map
  default = {}
}
