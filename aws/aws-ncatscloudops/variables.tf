variable "AWS_REGION" {
  default = "us-east-1"
}

variable "platform_service_default_group_name" {
  type    = string
  default = ""
}

variable "IAM_role_arn" {
  type    = string
  default = ""
}

variable "common_tags" {
  type    = map(any)
  default = {}
}

variable "project_tags" {
  type = list(string)
}
/*
###Config###

variable "config_s3_bucket_name" {
  type    = string
  default = ""
}

variable "aws_config_sns_topic_name" {
  type    = string
  default = ""
}

variable "aws_config_sqs_name" {
  type    = string
  default = ""
}

##Guardduty###

variable "guardduty_sns_topic_name" {
  type    = string
  default = ""
}

variable "guardduty_sqs_name" {
  type    = string
  default = ""
}

variable "guardduty_logs_s3_bucket_name" {
  type    = string
  default = ""
}

variable "guardduty_event_name" {
  type    = string
  default = ""
}

variable "guardduty_subscription_email" {
  type    = string
  default = ""
}
*/
###VPC_flow_logs####

variable "flowlogrole_name" {
  type    = string
  default = ""
}

variable "flowlogrole_policy_name" {
  type    = string
  default = ""
}


####DNS_query_logs###

variable "zone_id" {
  type    = list(string)
  default = []
}

###SGC_AWS_Systems_Manager###

variable "aws_ssm_sgc_bucket_name" {
  type = string
}

variable "document_content" {
  type = string
}

variable "windows_document_content" {
  type = string
}

######Resource_Decommission####
variable "key" {
  description = "The value for the project tag"
  type        = string
  default     = ""
}
variable "key_value" {
  description = "The value for the project tag"
  type        = string
  default     = ""
}
variable "email_subscription_endpoint" {
  description = "Email address for SNS topic email subscription"
  type        = string
  default     = ""
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

###CPE Approved Security Groups####

variable "sg_egress" {
  type = any
}

###EIC endpoint###

variable "EIC_vpc_ids" {
  type = map(object({
    vpc_id     = string // vpc ids
    subnet_ids = list(string) // associated subnet_ids
  }))
}

##ABAC policy###
variable "ec2_policyname" {
  description = "The name of the Resource policy"
  type        = string
  default     = ""
}

###Cost-Reports###

variable "cost_report_bucket_name" {
  type = string
}

variable "lambda_cost_report_role_name" {
  type = string
}

variable "lambda_cost_report_policy_name" {
  type = string
}

variable "lambda_function_cost_report_name" {
  type = string
}

variable "cost_report_name" {
  type = string
}

variable "ACCESS_TEAM_LIST" {
  type = string
}

variable "PROGRAM_PROJECT_MAP" {
  type = any
}