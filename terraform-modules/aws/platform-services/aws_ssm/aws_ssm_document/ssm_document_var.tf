variable "document_name" {
  type = string
}

variable "document_type" {
  type = string
  default = "Command"
}

variable "document_content" {
  type = string
}

variable "document_tags" {
  description = "Additional tags for the S3 bucket"
  type        = map(string)
  default     = {}
}