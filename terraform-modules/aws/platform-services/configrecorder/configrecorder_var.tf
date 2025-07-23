variable "aws_config_recorder" {
  type    = string
  default = "aws-congigrecorder"
}

variable "aws_configdelivery" {
  type    = string
  default = "configdelivery"
}

variable "aws_config_s3_bucket" {
  type    = string
  default = ""
}

variable "aws_config_sns_topic_arn" {
  type    = string
  default = ""
}

variable "aws_config_policy" {
  type    = string
  default = "awsconfig-roleploicy"
}

variable "aws_iam_service_linked_role" {
  type        = bool
  default     = false
}

variable "s3_bucket_tags" {
  type    = map(any)
  default = {}
}

