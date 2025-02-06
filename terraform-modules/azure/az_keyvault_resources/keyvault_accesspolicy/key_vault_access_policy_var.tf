variable "keyvault-id" {
  description = "Please provide KeyVault ID (Required)"
  type = string
  default = null
}

variable "tenant-id" {
  description = "Please provide Tenant ID (Required)"
  type = string
  default = null
}

variable "object-id" {
  description = "Please provide Object ID (Required)"
  type = string
  default = null
}

variable "application-id" {
  description = "Please provide Application ID (Optional)"
  type = string
  default = null
}

variable "certificate-permissions" {
  description = "Please provide Certificate Permissions (Optional)"
  type = list(string)
  default = []
}

variable "key-permissions" {
  description = "Please provide Key Permissions (Optional)"
  type = list(string)
  default = []
}

variable "secret-permissions" {
  description = "Please provide Secret Permissions (Optional)"
  type = list(string)
  default = []
}

variable "storage-permissions" {
  description = "Please provide Storage Permissions (Optional)"
  type = list(string)
  default = []
}
