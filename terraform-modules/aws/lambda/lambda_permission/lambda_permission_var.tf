variable "lambda_permission_statement_id" {
  description = "ID for the Lambda permission statement"
  type        = string
  default     = "AllowInvokeFromEvent"
}

variable "lambda_permission_action" {
  description = "Action for Lambda permission"
  type        = string
  default     = "lambda:InvokeFunction"
}

variable "lambda_permission_function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_permission_principal" {
  description = "Principal for the Lambda permission"
  type        = string
  default     = "events.amazonaws.com"
}

variable "lambda_permission_source_arn" {
  description = "Source ARN for the Lambda permission"
  type        = string
}
