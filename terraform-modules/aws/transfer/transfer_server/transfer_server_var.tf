variable "transfer_server_endpoint_details" {
  type = any
  default = {}
}

variable "transfer_server_endpoint_type" {
  type = string
  default = null
}

variable "transfer_server_invocation_role" {
  type = string
  default = null
}

variable "transfer_server_host_key" {
  type = string
  default = null
}

variable "transfer_server_url" {
  type = string
  default = null
}

variable "transfer_server_identity_provider_type" {
  type = string
  default = null
}

variable "transfer_server_logging_role" {
  type = string
  default = null
}

variable "transfer_server_force_destroy" {
  type = string
  default = null
}

variable "transfer_server_vpc_endpoint_id" {
  type = string
  default = null
}

variable "transfer_server_tags" {
  type = map
  default = {}
}
