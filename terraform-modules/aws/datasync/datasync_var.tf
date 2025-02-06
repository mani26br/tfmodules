variable "source_s3_bucket_arn" {
  type        = string
  default     = ""
}

variable "source_prefix" {
  type        = string
  default     = ""
}

variable "destination_s3_bucket_arn" {
  type        = string
  default     = ""
}

variable "destination_prefix" {
  type        = string
  default     = ""
}

variable "iam_role_arn" {
  type        = string
  default     = ""
}
