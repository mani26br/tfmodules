variable "virtual_machine_id" {
  type = string
  default = ""
}

variable "location" {
  type = string
  default = ""
}

variable "enabled" {
  type = bool
  default = false
}

variable "daily_recurrence_time" {
  type = string
  default = ""
}

variable "timezone" {
  type = string
  default = ""
}

variable "shutdown_notifications" {
  type = list
  default = []
}

variable "ignore_changes" {
  type = list
  default = []
}

variable "notifications_enabled" {
  type = bool
  default = false
}

variable "time_in_minutes" {
  type = string
  default = "60"
}

variable "webhook_url" {
  type = string
  default = ""
}
