variable "name" {
  description = "The name of the AWS Systems Manager Maintenance Window."
  type        = string
}

variable "schedule" {
  description = "The schedule specifying when the Maintenance Window will run. This follows the cron or rate syntax."
  type        = string
}

variable "duration" {
  description = "The duration of the Maintenance Window in hours."
  type        = number
}

variable "cutoff" {
  description = "The number of hours before the end of the Maintenance Window when new tasks can no longer be started."
  type        = number
}

variable "schedule_timezone" {
  description = "The timezone for the schedule of the AWS SSM Maintenance Window."
  type        = string
  default     = ""
}

variable "tags" {
  description = "The tags"
  type = map(string)
  default = {}
}