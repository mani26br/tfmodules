variable "vpc_id" {
description = "VPC ID for the vpc flow logs"
type = string
default = ""
}

variable "vpc_flow_log_group_name" {
description = "VPC flow logs cloudwatch log group name"
type = string
default= "vpc-flow-logs"
}

variable "vpc_flow_log_group_name_prefix" {
description = "VPC flow logs cloudwatch log group name prefix"
type = string
default = ""

}

variable "vpc_log_destination_type" {
description = "VPC flow logs destination type"
type = string
default = "cloud-watch-logs"

}

variable "vpc_traffic_type" {
description = "VPC flow logs traffic type"
type = string
default = "ALL"

}

variable "cloudwatch_log_tags" {
description = "cloudwatch log tags"
type = map(string)
default = {}
}

variable "vpc_flow_log_tags" {
description = "flow log tags"
type = map(string)
default = {}
}

variable "flow_log_role_arn" {
  type = any
}

variable "retention_period" {
  type = number
  default = 0
}

variable "environment" {
  type = string
}
