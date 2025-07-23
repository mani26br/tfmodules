variable "lambda_function_filename" {
  type    = string
  default = null
}

variable "lambda_function_s3_bucket" {
  type    = string
  default = null
}

variable "lambda_function_s3_key" {
  type    = string
  default = null
}

variable "lambda_function_s3_object_version" {
  type    = string
  default = null
}

variable "lambda_function_name" {
  type    = string
  default = ""
}

variable "lambda_function_dead_letter_config" {
  type    = any
  default = {}
}

variable "lambda_function_handler" {
  type    = string
  default = ""
}

variable "lambda_function_role" {
  type    = string
  default = ""
}

variable "lambda_function_description" {
  type    = string
  default = null
}

variable "lambda_function_layers" {
  type    = list
  default = []
}

variable "lambda_function_memory_size" {
  type    = string
  default = null
}

variable "lambda_function_runtime" {
  type    = string
  default = ""
}

variable "lambda_function_timeout" {
  type    = string
  default = null
}

variable "lambda_function_reserved_concurrent_executions" {
  type    = string
  default = null
}

variable "lambda_function_publish" {
  type    = string
  default = null
}

variable "lambda_function_vpc_config" {
  type    = any
  default = {}
}

variable "lambda_function_environment" {
  type    = any
  default = {}
}

variable "lambda_function_kms_key_arn" {
  type    = string
  default = null
}

variable "lambda_function_source_code_hash" {
  type    = string
  default = null
}

variable "lambda_function_tags" {
  type    = map
  default = {}
}

variable "environment" {
  type = object({
    variables = map(string)
  })
  default = null
}
