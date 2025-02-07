variable "AWS_REGION" {
  default = "us-east-1"
}

variable "IAM_role_arn" {
  type    = string
  default = ""
}

variable "common_tags" {
  type    = map(any)
  default = {}
}

###ServiceNow_Mid_Server###

variable "mid_server_instance_ami" {
 type  = string
 default = ""
}

variable "mid_server_subnet_id" {
  type = string
  default = ""
}

variable "mid_server_key" {
  type = string
  default = ""
}

###CPE Approved Security Groups####

variable "sg_egress" {
  type = any
}

###EIC endpoint###

variable "EIC_vpc_ids" {
  type = map(object({
    vpc_id     = string // vpc ids
    subnet_ids = list(string) // associated subnet_ids
    project_tags = list(string) // project tags
  }))
}

###Compliance_Report###

variable "compliance_report_bucket_name" {
  type = string
}

variable "lambda_compliance_report_role_name" {
  type = string
}

variable "lambda_compliance_report_policy_name" {
  type = string
}

variable "lambda_function_compliance_report_name" {
  type = string
}

variable "compliance_report_name" {
  type = string
}

variable "eventbridge_scheduler_role_name" {
  type = string
}

variable "eventbridge_scheduler_role_policy_name" {
  type = string
}