variable "config_name" {
  description = "The name of the AWS Config instance."
  type        = string
  default     = "aws-config"
}

variable "config_aggregator_name" {
  description = "The name of the aggregator."
  type        = string
  default     = "organization"
}

variable "aggregate_organization" {
  description = "Aggregate compliance data by organization"
  type        = bool
  default     = false
}

variable "tags" {
  type    = map(any)
  default = {}
}
