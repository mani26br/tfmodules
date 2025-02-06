variable "key_rotation_trigger" {
  description = "Name for the EC2 Instance Termination CloudWatch Event Rule"
  type        = string
  default     = "KeyRotationTrigger-poc"
}
variable "vault_role_id" {
  default = ""
}
variable "vault_url" {
  default = ""
}
variable "vault_secret_id" {
  default = ""
}
variable "approle_name" {
  default = ""
}
variable "user_name" {
  type    = list(string)
  default = []
}
variable "lambda_function_name" {
  description = "Name for the AWS Lambda function"
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
variable "existing_role_arn" {
  type        = string
  description = "ARN of the existing IAM role to be used by the Lambda function"
  default = ""
}
variable "secret_path" {
  type    = string
  default = ""
}


