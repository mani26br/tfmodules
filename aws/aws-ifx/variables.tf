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

variable "splunk_connection_role_name" {
  type    = string
  default = ""
}

variable "cloudtrail_name" {
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

####DNS_query_logs###

variable "zone_id" {
  type    = list(string)
  default = []
}

###AWS_Systems_Manager###

variable "install_cw_agent_parameters" {
  type = map(string)
}

variable "aws_ssm_bucket_name" {
  type = string
}

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

###AWS_WAF_Logs#####
variable "wafv2_web_acl_arn" {
 description = "Whether to create the WebACL"
 type        = string
 default     = ""
}
variable "attached_albs" {
 type    = list(string)
 description = "List of ALB ARNs"
 default = []
}
variable "existing_waf" {
 description = "Name of the existing WAF Web ACL"
 type        = string
 default     = ""
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
    project_tags = list(string)
  }))
}

###EIC_SG_Attachment_Lambda_Function####

variable "eic_sg_attachment_role_name" {
  type = string
}

variable "eic_sg_attachment_policy_name" {
  type = string
}

variable "lambda_function_eic_sg_attachment_name" {
  type = string
}

variable "ec2_project_values" {
  type    = any
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

###CloudWatchAlarms##

variable "metric_namespace" {
  type = string
}

variable "cloudtrail_loggroup_name" {
  type = string
}