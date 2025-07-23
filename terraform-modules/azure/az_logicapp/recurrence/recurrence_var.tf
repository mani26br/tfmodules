
variable "logic_app_action_http_action" {
  type = string
  default = ""
}

variable "logicapp_trigger_name" {
  type = string
  default = ""
}

variable "frequency" {
  type = string
  default = ""
}

variable "start_time" {
  type = string
  default = ""
}

variable "time_zone" {
  type = string
  default = ""
}

variable "schedule_job"{
    type = list
    default = []
}

variable "interval" {
  type = string
  default = "1"
}



