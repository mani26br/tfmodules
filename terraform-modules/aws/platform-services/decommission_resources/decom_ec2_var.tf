
variable "aws_region" {
  description = "The AWS region where resources will be deployed"
  default     = "us-east-1"  # Replace with your default region
}

variable "key" {
  description = "The value for the project tag"
  type        = string
  default     = ""
}
variable "key_value" {
  description = "The value for the project tag"
  type        = string
  default     = ""
}

variable "instance_termination_rule_name" {
  description = "Name for the EC2 Instance Termination CloudWatch Event Rule"
  type        = string
  default     = "instance_termination_rule"
}

variable "sns_topic_name" {
  description = "Name for the SNS topic used for instance termination notifications"
  type        = string
  default     = "InstanceTerminationNotifications"
}

variable "lambda_function_name" {
  description = "Name for the AWS Lambda function"
  type        = string
  default     = "InstancTerminationLambda"
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
