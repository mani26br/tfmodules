variable "bucket_notification_bucket" {
  type    = string
  default = ""
}

variable "bucket_notification_topic" {
  type    = any
  default = []
}

variable "bucket_notification_queue" {
  type    = any
  default = []
}

variable "bucket_notification_lambda_function" {
  type    = any
  default = []
}
