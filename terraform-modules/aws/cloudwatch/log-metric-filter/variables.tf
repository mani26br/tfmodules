variable "create_cloudwatch_log_metric_filter" {
  description = "Whether to create the Cloudwatch log metric filter"
  type        = bool
  default     = true
}

variable "name" {
    description = "name of the metric filter"
    type = string
    default = ""
}

variable "pattern" {
    description = "A valid CloudWatch Logs filter pattern for extracting metric data out of ingested log events."
    type = string
    default = "" 
}

variable "log_group_name" {
    description = "The name of the log group to associate the metric filter with."
    type = list(string)
}

variable "metric_transformation_name" {
    description = "The name of the CloudWatch metric to which the monitored log information should be published"
    type = string
    default = ""
}

variable "metric_transformation_namespace" {
    description = "The destination namespace of the CloudWatch metric."
    type = string
    default = ""
}

variable "metric_transformation_value" {
    description = "What to publish to the metric."
    type = number
    default = 1
}

variable "metric_transformation_default_value" {
    description = "the value to emit when a filter pattern does not match a log event."
    type = number
    default = null
}

