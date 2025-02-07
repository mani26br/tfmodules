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
/*
variable "zone_id" {
  type    = list(string)
  default = []
}
*/

###SGC_AWS_Systems_Manager###

variable "aws_ssm_sgc_bucket_name" {
  type = string
}