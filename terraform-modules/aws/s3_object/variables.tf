variable "bucket" {
  description = "(Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name."
  type        = string
  default     = null
}

variable "acl" {
  description = "(Optional) The canned ACL to apply. Defaults to 'private'."
  type        = string
  default     = "private"
}

//S3 folder object variables
variable "key" {
  description = "The name of the object once it is in the bucket."
  type        = string
  default     = "null"
}

variable "content_type" {
  description = "A standard MIME type describing the format of the object data, e.g. application/octet-stream. All Valid MIME Types are valid for this input"
  type        = string
  default     = "application/x-directory"
}

variable "kms_key_id" {
  description = "(Optional) The encryption key if any."
  type        = string
  default     = ""
}
