variable "target_bucket_name" {
  description = "Map containing access bucket logging configuration."
  type        = string
  default     = ""
}

variable "target_prefix" {
  description = "prefix for the target bucket"
  type        = string
  default     = ""
}

variable "source_logging_bucket" {
  description = "prefix for the target bucket"
  type        = string
  default     = ""
}
