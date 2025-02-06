variable "name" {
  type = string
}

variable "task_arn" {
  description = "The Amazon Resource Name (ARN) of the task to be executed in the Maintenance Window."
  type        = string
}

variable "task_type" {
  description = "The type of task to execute in the Maintenance Window (e.g., 'RUN_COMMAND', 'AUTOMATION', 'LAMBDA', 'STEP_FUNCTIONS')."
  type        = string
  default = "RUN_COMMAND"
}

variable "window_id" {
  description = "The ID of the AWS SSM Maintenance Window where the task will be executed."
  type        = string
}

variable "window_target_key" {
  description = "The target key for the AWS SSM Maintenance Window Task."
  type = string
  default = "WindowTargetIds"
}

variable "window_target_ids_values" {
  description = "The list of target IDs for the AWS SSM Maintenance Window Task."
  type        = list(string)
}

variable "output_s3_bucket" {
  description = "The Amazon S3 bucket where the command execution results will be stored."
  type        = string
  default = ""
}

variable "output_s3_key_prefix" {
  description = "The Amazon S3 keey prefix where the command execution results will be stored."
  type = string
  default = ""
}

variable "service_role_arn" {
  description = "The ARN of the IAM role that the Systems Manager service uses to run the task."
  type        = string
}

variable "notification_arn" {
  description = "The Amazon Resource Name (ARN) of the SNS topic for task notifications."
  type        = string
  default = null
}

variable "parameter" {
  description = "A map of parameters for the SSM command."
  type        = map(string)
  default = {}
}

variable "priority" {
 type = number 
}