###Guardduty###
output "gd_sqs_queue_arn" {
  description = "The ARN of the Guardduty SQS queue"
  value       = module.sqs_guardduty.base_queue_arn
}

output "gd_sqs_queue_id" {
  description = "The id of the SQS queue"
  value       = module.sqs_guardduty.base_queue_url
}

output "gd_sns_topic_arn" {
  description = "The ARN of the Guardduty SNS topic"
  value       = module.sns_guardduty_notifications.sns_topic_arn
}

###Config###
output "config_sqs_queue_arn" {
  description = "The ARN of the AWS Config SQS queue"
  value       = module.sqs_aws_config.base_queue_arn
}

output "config_sns_topic_arn" {
  description = "The ARN of the AWS Config SNS topic"
  value       = module.sns_aws_config_notifications.sns_topic_arn
}

output "config_sqs_queue_id" {
  description = "The id of the SQS queue"
  value       = module.sqs_aws_config.base_queue_url
}

###VPC_flow_log###
locals {
  vpc_flowlog_instances = {
    for vpc_id in data.aws_vpcs.current.ids :
    vpc_id => module.vpc_flowlog[vpc_id]
  }
}

output "vpc_flowlog_instances" {
  value = local.vpc_flowlog_instances
}

output "flow_log_role_arn"{
  value = module.flowlogrole.iam_role_arn
}

###DNS-Query-Logs

locals {
  DNS_flowlog_Groups = {
    for zone_id in var.zone_id:
    zone_id => module.dns_query_logs[zone_id]
  }
}

output DNS_flowlog_Groups {
  value       = local.DNS_flowlog_Groups
}

###AWS_WAF_logs###

output "waf_cloudwatch_log_group_name" {
  value = module.aws-waf-logs.waf_cloudwatch_log_group_name
}