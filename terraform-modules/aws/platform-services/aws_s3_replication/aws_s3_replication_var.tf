
variable "destination_bucket" {
  type        = string
  default     = ""
  description = "Name of the destionation bucket"
}

variable "existing_bucket" {
  type        = string
  default     = ""
  description = "Name of the existing bucket"
}

variable "destination_account" {
  type        = string
  default     = ""
  description = "ID of the destination account"
}

variable "replication_role" {
  type        = string
  default     = ""
  description = "arn of the replication role"
}

variable "s3_bucket_prefix" {
  type        = string
  default     = ""
  description = "mention the prefix for the S3 bucket"
}

