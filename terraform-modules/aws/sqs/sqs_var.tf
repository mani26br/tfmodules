variable "queue_name" {
  description = "The name of the queue. Used as a prefix for related resource names."
  type = string
}

variable "sqs_queue_url" {
  description = "The url of the queue. Used as a prefix for related resource names."
  type = string
}

variable "queue_policy" {
  description = "This is the queue access policy."
  type = string
  default = ""
}


variable "retention_period" {
  description = "Time (in seconds) that messages will remain in queue before being purged"
  type = number
  default = 86400
}


variable "visibility_timeout" {
  description = "Time (in seconds) that consumers have to process a message before it becomes available again"
  type = number
  default = 300
}


variable "receive_count" {
  description = "The number of times that a message can be retrieved before being moved to the dead-letter queue"
  type = number
  default = 3
}
