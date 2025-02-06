variable "create_aws_s3_bucket_acl" {
  description = "Whether to create s3 bucket acl"
  type        = bool
  default     = true
}

variable "create_aws_s3_bucket_policy" {
  description = "Whether to create s3 bucket policy"
  type        = bool
  default     = true
}

variable "bucket" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "aws_s3_bucket_object_storage" {
  description = "Whether to have s3 bucket object"
  type        = bool
  default     = false
}

variable "s3_bucket_prefix" {
  description = "Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket."
  type        = string
  default     = null
}

variable "region" {
  description = "AWS region for the S3 bucket"
  type        = string
  default = "us-east-1"
}

variable "bucket_tags" {
  description = "Additional tags for the S3 bucket"
  type        = map(string)
  default     = {}
}

variable "policy" {
  description = "Policy JSON for the S3 bucket"
  type        = string
  default = ""
}

variable "kms_master_key_id" {
  description = "AWS KMS master key ID used for the SSE-KMS encryption"
  type = string
  default = null
}

variable "sse_algorithm" {
  description = "Server-side encryption algorithm to use."
  type = string
  default = "AES256"
}

variable "object_ownership" {
  type = string
  default = "BucketOwnerPreferred"
}