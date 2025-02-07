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

###CloudTrail###

variable "aws_cloudtrail_sns_topic_name" {
  type    = string
  default = ""
}

variable "aws_cloudtrail_sqs_name" {
  type    = string
  default = ""
}

variable "cloudtrail_s3_bucket" {
  type    = string
  default = ""
}

variable "cloudtrail_kms_alias_name" {
  type    = string
  default = ""
}

variable "cloudtrail_name" {
  type    = string
  default = ""
}

variable "splunk_connection_role_name" {
  type    = string
  default = ""
}

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


variable "common_tags" {
  type    = map(any)
  default = {}
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

###VPC_flow_logs####

variable "flowlogrole_name" {
  type    = string
  default = ""
}

variable "flowlogrole_policy_name" {
  type    = string
  default = ""
}

variable "guardduty_kms_alias_name" {
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

###Compliance_Report###

variable "compliance_report_bucket_name" {
  type = string
}

variable "compliance_report_bucket_name_us_east_2" {
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

variable "compliance_report_lambda_function_us_east_2" {
  type = string
}

###CPE Approved Security Groups####

variable "sg_egress" {
  type = any
}