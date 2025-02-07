variable "AWS_REGION" {
  default = "us-east-2"
}

variable "platform_service_default_group_name" {
  type    = string
  default = ""
}

variable "IAM_role_arn" {
  type    = string
  default = ""
}

###S3_tfstate_replication###

variable "existing_tfstate_bucket_name" {
  type    = string
  default = ""
}

variable "destination_tfstate_bucket_name" {
  type    = string
  default = ""
}

variable "destination_account_number" {
  type    = string
  default = ""
}

variable "s3_tfstate_bucket_prefix" {
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

variable "guardduty_kms_alias_name" {
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
/*
####DNS_query_logs###

variable "zone_id" {
  type    = list(string)
  default = []
}
*/

###AWS S3 Access Logs#####

variable "aws_s3_accesslogs_destination_bucket" {
  type = string
  default = ""
}

variable "source_logging_bucket" {
  type = list(string)
  default = []
}

variable "accesslogs_sqs_queue_name" {
  description = "Name of the existing WAF Web ACL"
  type        = string
  default     = ""
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

variable "lambda_function_compliance_report_name" {
  type = string
}

variable "compliance_report_name" {
  type = string
}

###CPE Approved Security Groups####

variable "sg_egress" {
  type = any
}