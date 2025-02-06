variable "create_targets" {
  type    = bool
  default = true
}

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
  default = "AUTOMATION"
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
  default = null
}

variable "parameter" {
  description = "A map of parameters for the SSM command."
  type        = any
  default = {}
}

variable "priority" {
 type = number 
}

variable "service_role_arn" {
  type = string
  default = null
}

variable "max_concurrency" {
  type = number
  default = 10
}

variable "max_errors" {
  type = number
  default = 1
}