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

variable "project_tags" {
  type = list(string)
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
/*
####DNS_query_logs###

variable "zone_id" {
  type    = list(string)
  default = []
}
*/

###AWS_Systems_Manager###

variable "cw_agent_config" {
  type = string
}

variable "window_cw_agent_config" {
  type = string
}

variable "install_cw_agent_parameters" {
  type = map(string)
}

variable "configure_cw_agent_parameters" {
  type = map(string)
}

variable "configure_window_cw_agent_parameters" {
  type = map(string)
}

variable "status_cw_agent_parameters" {
  type = map(string)
}

variable "status_ssm_agent_parameters" {
  type = map(string)
}

variable "aws_ssm_bucket_name" {
  type = string
}

###SGC_AWS_Systems_Manager###

variable "aws_ssm_sgc_bucket_name" {
  type = string
}

###CloudWatchAlarms##

variable "metric_namespace" {
  type = string
}

variable "cloudtrail_loggroup_name" {
  type = string
}

variable "cloudwatchalerts_sns_topic_name" {
  type    = string
}

locals {
  CloudTrailMetrics = {
    "CloudTrailChange" = "{($.eventName=CreateTrail) || ($.eventName=UpdateTrail) || ($.eventName=DeleteTrail) || ($.eventName=StartLogging) || ($.eventName=StopLogging)}"
    "IamCreateAccessKey" = "{($.eventName=CreateAccessKey)}"
    "IamDeleteAccessKey" = "{($.eventName=DeleteAccessKey)}"
    "IamPolicyChanges" = "{($.eventName=DeleteGroupPolicy) || ($.eventName=DeleteRolePolicy) || ($.eventName=DeleteUserPolicy) || ($.eventName=PutGroupPolicy) || ($.eventName=PutRolePolicy) || ($.eventName=PutUserPolicy) || ($.eventName=CreatePolicy) || ($.eventName=DeletePolicy) || ($.eventName=CreatePolicyVersion) || ($.eventName=DeletePolicyVersion) || ($.eventName=AttachRolePolicy) || ($.eventName=DetachRolePolicy) || ($.eventName=AttachUserPolicy) || ($.eventName=DetachUserPolicy) || ($.eventName=AttachGroupPolicy) || ($.eventName=DetachGroupPolicy)}"
    "NetworkACLChanges" = "{($.eventName=CreateNetworkAcl) || ($.eventName=CreateNetworkAclEntry) || ($.eventName=DeleteNetworkAcl) || ($.eventName=DeleteNetworkAclEntry) || ($.eventName=ReplaceNetworkAclEntry) || ($.eventName=ReplaceNetworkAclAssociation)}"
    "NetworkGatewayChanges" = "{($.eventName=CreateCustomerGateway) || ($.eventName=DeleteCustomerGateway) || ($.eventName=AttachInternetGateway) || ($.eventName=CreateInternetGateway) || ($.eventName=DeleteInternetGateway) || ($.eventName=DetachInternetGateway)}"
    "RouteTableChanges" = "{($.eventName=CreateRoute) || ($.eventName=CreateRouteTable) || ($.eventName=ReplaceRoute) || ($.eventName=ReplaceRouteTableAssociation) || ($.eventName=DeleteRouteTable) || ($.eventName=DeleteRoute) || ($.eventName=DisassociateRouteTable)}"
    "S3BucketPolicyChanges" = "{($.eventSource=s3.amazonaws.com) && (($.eventName=PutBucketAcl) || ($.eventName=PutBucketPolicy) || ($.eventName=PutBucketCors) || ($.eventName=PutBucketLifecycle) || ($.eventName=PutBucketReplication) || ($.eventName=DeleteBucketPolicy) || ($.eventName=DeleteBucketCors) || ($.eventName=DeleteBucketLifecycle) || ($.eventName=DeleteBucketReplication))}"
    "SecurityGroupChanges" = "{($.eventName=AuthorizeSecurityGroupIngress) || ($.eventName=AuthorizeSecurityGroupEgress) || ($.eventName=RevokeSecurityGroupIngress) || ($.eventName=RevokeSecurityGroupEgress) || ($.eventName=CreateSecurityGroup) || ($.eventName=DeleteSecurityGroup)}" 
    "UnauthorizedOperation" = "{($.errorCode=\"*UnauthorizedOperation\") || ($.errorCode=\"AccessDenied*\")}"
    "VPCChanges" = "{($.eventName=CreateVpc) || ($.eventName=DeleteVpc) || ($.eventName=ModifyVpcAttribute) || ($.eventName=AcceptVpcPeeringConnection) || ($.eventName=CreateVpcPeeringConnection) || ($.eventName=DeleteVpcPeeringConnection) || ($.eventName=RejectVpcPeeringConnection) || ($.eventName=AttachClassicLinkVpc) || ($.eventName=DetachClassicLinkVpc) || ($.eventName=DisableVpcClassicLink) || ($.eventName=EnableVpcClassicLink)}"
    "KMSKeyDeletion" =  "{($.eventSource=kms.amazonaws.com) && (($.eventName=DisableKey) || ($.eventName=ScheduleKeyDeletion))}"
    "AWSConfigChanges" = "{($.eventSource=config.amazonaws.com) && (($.eventName=StopConfigurationRecorder) || ($.eventName=DeleteDeliveryChannel) || ($.eventName=PutDeliveryChannel) || ($.eventName=PutConfigurationRecorder))}"
    "ConsoleLoginFailed" = "{($.eventName=ConsoleLogin) && ($.errorMessage=\"Failed authentication\")}"
    "RootAccountUsage" = "{$.userIdentity.type=\"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType !=\"AwsServiceEvent\"}"
    "ConsoleLoginWithoutMFA" = "{ ($.eventName =\"ConsoleLogin\") && ($.additionalEventData.MFAUsed !=\"Yes\") && ($.userIdentity.type =\"IAMUser\") && ($.responseElements.ConsoleLogin =\"Success\") }"
  }
}

####S3 Destination Bucket###

variable "destination_bucket_name" {
  type    = string
  default = ""
}

variable "soruce_account_iam_roles" {
  type    = list(string)
  default = []
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

