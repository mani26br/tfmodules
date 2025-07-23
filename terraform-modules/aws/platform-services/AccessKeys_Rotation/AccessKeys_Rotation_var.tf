variable "key_rotation_trigger" {
  description = "Name for the EC2 Instance Termination CloudWatch Event Rule"
  type        = string
  default     = ""
}

variable "sns_topic_name" {
  description = "Name for the SNS topic used for instance termination notifications"
  type        = string
  default     = ""
}

variable "lambda_function_name" {
  description = "Name for the AWS Lambda function"
  type        = string
  default     = ""
}

variable "email_subscription_endpoint" {
  description = "Email address for SNS topic email subscription"
  type        = string
  default     = ""
}

variable "retention_period" {
  type    = number
  default = 0
}

variable "environment" {
  type    = string
  default = ""
}
