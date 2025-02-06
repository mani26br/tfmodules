variable "association_name" {
  description = "The descriptive name for the association"
  type = string
  default = " "
}

variable "name" {
  description = "The name of the SSM association"
  type        = string
}

variable "parameters" {
  description = "The parameters for the SSM association"
  type        = map(string)
  default = null
}

variable "key" {
  description = "The key for the SSM association target"
  type        = string
  default = "InstanceIds"
}

variable "values" {
  description = "The instance ids or tags for the SSM association target"
  type        = any
  default =[]
}

variable "s3_bucket_name" {
  description = "The name of the s3 bucket receiving aws ssm command logs"
  type = string
  default = ""
}

variable "s3_key_prefix" {
  description = "the key prefix for the bucket that receives the output"
  type = string
  default = ""
}

variable "schedule_expression" {
  description = "A cron or rate expression that specifies when the association runs"
  type = string
}