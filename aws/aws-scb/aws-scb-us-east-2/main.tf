###S3_tfstate_replication_IAM_role###
module "s3_replication_role"{
  source = "../../../terraform-modules/aws/iam/iam_role"
  iam_role_name = "s3_replication_role"
  iam_role_assume_role_policy = data.aws_iam_policy_document.s3_replication_assume_role_policy.json
  iam_role_policy_name = "s3_tfstate_replication_role_policy"
  iam_role_policy = data.aws_iam_policy_document.s3_tfstate_replication_policy.json
  iam_role_tags = var.common_tags
}

##S3_tfstate_replication##
module "S3_replication" {
  source = "../../../terraform-modules/aws/platform-services/aws_s3_replication"
  replication_role = module.s3_replication_role.iam_role_arn
  existing_bucket = var.existing_tfstate_bucket_name
  s3_bucket_prefix = var.s3_tfstate_bucket_prefix
  destination_bucket = var.destination_tfstate_bucket_name
  destination_account = var.destination_account_number
}

###configs###
module "sns_aws_config_notifications"{
  source = "../../../terraform-modules/aws/sns/sns_topics"
  sns_topic_name = var.aws_config_sns_topic_name
  sns_topic_display_name = var.aws_config_sns_topic_name
  sns_topic_tags = var.common_tags
  sns_topic_policy = data.aws_iam_policy_document.config_sns_topic_policy.json
}

module "sqs_aws_config"{
  source = "../../../terraform-modules/aws/sqs"
  queue_name = var.aws_config_sqs_name
  sqs_queue_url = module.sqs_aws_config.base_queue_url
  queue_policy = data.aws_iam_policy_document.config_sqs_queue_policy.json
}

module "config_sns_topic_subscription"{
  source = "../../../terraform-modules/aws/sns/sns_topic_subscription"
  sns_topic_subscription_topic_arn = module.sns_aws_config_notifications.sns_topic_arn
  sns_topic_subscription_protocol = "sqs"
  sns_topic_subscription_endpoint =  module.sqs_aws_config.base_queue_arn
}


module "aws_configrecorder"{
  source = "../../../terraform-modules/aws/platform-services/configrecorder/"
  aws_config_s3_bucket = var.config_s3_bucket_name
  aws_config_sns_topic_arn = module.sns_aws_config_notifications.sns_topic_arn
  s3_bucket_tags       = var.common_tags
}

module "aws-NIST-800-53-configrules" {
  source = "../../../terraform-modules/aws/platform-services/configrules/"
  depends_on = [module.aws_configrecorder]
}

module "aws_required_tags_rule"{
  source = "../../../terraform-modules/aws/platform-services/configrules/required-tags-rule"
  depends_on = [module.aws_configrecorder]
}


###Guard_Duty###

module "sns_guardduty_notifications"{
  source = "../../../terraform-modules/aws/sns/sns_topics"
  sns_topic_name = var.guardduty_sns_topic_name
  sns_topic_display_name = var.guardduty_sns_topic_name
  sns_topic_tags = var.common_tags
  sns_topic_policy = data.aws_iam_policy_document.gd_sns_topic_policy.json 
}

module "sqs_guardduty"{
  source = "../../../terraform-modules/aws/sqs"
  queue_name = var.guardduty_sqs_name
  sqs_queue_url = module.sqs_guardduty.base_queue_url
  queue_policy = data.aws_iam_policy_document.gd_sqs_queue_policy.json 
}

module "gd_sns_topic_subscription"{
  source = "../../../terraform-modules/aws/sns/sns_topic_subscription"
  sns_topic_subscription_topic_arn = module.sns_guardduty_notifications.sns_topic_arn
  sns_topic_subscription_protocol = "sqs"
  sns_topic_subscription_endpoint =  module.sqs_guardduty.base_queue_arn
}

module "gd_sns_topic_email_subscription"{
  source = "../../../terraform-modules/aws/sns/sns_topic_subscription"
  sns_topic_subscription_topic_arn = module.sns_guardduty_notifications.sns_topic_arn
  sns_topic_subscription_protocol = "email"
  sns_topic_subscription_endpoint =  var.guardduty_subscription_email
}
  
module "aws_guard_duty"{
  source = "../../../terraform-modules/aws/platform-services/guard_duty"
  gd_kms_alias_name = var.guardduty_kms_alias_name
  guardduty_logs_s3_bucket = var.guardduty_logs_s3_bucket_name
  tags = var.common_tags
  guarddutyevent_name = var.guardduty_event_name
  notification_arn = module.sns_guardduty_notifications.sns_topic_arn
}

###securityhub###
module "aws_securityhub" {
  source = "../../../terraform-modules/aws/platform-services/securityhub/"
}

####AWS_Inspector###
module "aws_inspector"{
  source = "../../../terraform-modules/aws/platform-services/aws_inspector"
  current_account_id  = [data.aws_caller_identity.current.account_id]
}

###VPC_flow_logs###
module "flowlogrole" {
  source = "../../../terraform-modules/aws/iam/iam_role"
  iam_role_name = var.flowlogrole_name
  iam_role_assume_role_policy = data.aws_iam_policy_document.vpc_flow_assume_role_policy.json
  iam_role_policy_name = var.flowlogrole_policy_name
  iam_role_policy = data.aws_iam_policy_document.flow_log_role_policy.json
}
module "vpc_flowlog" {
  source = "../../../terraform-modules/aws/platform-services/vpc_flowlog"
  for_each = toset(data.aws_vpcs.current.ids)
  vpc_id = "${each.key}"
  flow_log_role_arn = module.flowlogrole.iam_role_arn
  environment = var.common_tags["environment"]
  cloudwatch_log_tags = var.common_tags
  vpc_flow_log_tags = var.common_tags
}

###DNS Query logs are not needed because they are regioanl specific only available with us-east-1
/*
###DNS_query_logs###
module "dns_query_logs"{
  source = "../../terraform-modules/aws/platform-services/dns_query_logs"
  for_each = toset(var.zone_id)
  zone_id = "${each.key}"
  environment = var.common_tags["environment"]
  cloudwatch_log_tags = var.common_tags
}
*/

###AWS S3 Access Logs#####

module "sqs_accesslogs_sqs_queue"{
  source = "../../../terraform-modules/aws/sqs"
  queue_name = var.accesslogs_sqs_queue_name
  sqs_queue_url = module.sqs_accesslogs_sqs_queue.base_queue_url
  queue_policy = data.aws_iam_policy_document.accesslogs_queue_policy.json 
}

module "aws_s3_accesslogs_destination_bucket" {
  source = "../../../terraform-modules/aws/platform-services/s3_bucket"
  aws_s3_bucket_object_storage = true
  bucket = var.aws_s3_accesslogs_destination_bucket
  create_aws_s3_bucket_policy = false
  s3_bucket_prefix = "s3accesslogs/"
  bucket_tags = var.common_tags
}

module "aws_s3_accesslogs_notifications" {
  source = "../../../terraform-modules/aws/platform-services/s3_notifications"
  bucket_prefix = "s3accesslogs/"
  aws_s3_notification_bucket = module.aws_s3_accesslogs_destination_bucket.s3_bucket_name
  aws_s3_bucket_notification_queue = module.sqs_accesslogs_sqs_queue.base_queue_arn
}

module "aws_s3_accesslogs" {
  source = "../../../terraform-modules/aws/platform-services/s3_access_logs"
  for_each = toset(var.source_logging_bucket)
  source_logging_bucket = "${each.key}"
  target_bucket_name = module.aws_s3_accesslogs_destination_bucket.s3_bucket_name
  target_prefix = "s3accesslogs/"
  depends_on = [module.aws_s3_accesslogs_destination_bucket]
}

###SGC_AWS_Systems_Manager###

module "aws_ssm_sgc_s3_bucket" {
  source = "../../../terraform-modules/aws/platform-services/s3_bucket"
  bucket = var.aws_ssm_sgc_bucket_name
  policy = data.aws_iam_policy_document.aws_ssm_sgc_s3_policy.json
  region = var.AWS_REGION
  bucket_tags = var.common_tags
}

module "aws_ssm_sgc_document" {
  source = "../../../terraform-modules/aws/platform-services/aws_ssm/aws_ssm_document"
  document_name = "SG-AWS-RunShellScript"
  document_content = var.document_content
}

module "aws_ssm_sgc_windows_document" {
  source = "../../../terraform-modules/aws/platform-services/aws_ssm/aws_ssm_document"
  document_name = "SG-AWS-RunPowerShellScript"
  document_content = var.windows_document_content
  document_tags = var.common_tags
}

###Compliance_Report###

module "compliance_report_s3_bucket" {
  source = "../../../terraform-modules/aws/platform-services/s3_bucket"
  bucket = var.compliance_report_bucket_name
  create_aws_s3_bucket_policy = false
  bucket_tags = var.common_tags
}

module "lambda_archive_compliance_report" {
  source = "../../../terraform-modules/aws/lambda/lambda_archive_file"
  lambda_archive_source_dir = "../../platform-services/lambda_scripts/compliance_report"
  lambda_archive_output_path = "../../platform-services/lambda_scripts/archive/compliance_report.zip"
}

module "lambda_function_compliance_report" {
  source = "../../../terraform-modules/aws/lambda/lambda_function"
  lambda_function_name = var.lambda_function_compliance_report_name
  lambda_function_description = "Creates compliance report & sends to s3 bucket"
  lambda_function_role = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-scb-compliance-report-role"
  lambda_function_runtime = "python3.8"
  lambda_function_handler = "required_tags.send_noncompliant_required_tags_report_to_s3"
  lambda_function_filename = module.lambda_archive_compliance_report.output_path
  lambda_function_source_code_hash = module.lambda_archive_compliance_report.hash
  lambda_function_timeout = 600
  lambda_function_tags = var.common_tags
  environment = {
    variables = {
      s3_bucket = var.compliance_report_bucket_name
      report_name = var.compliance_report_name
      config_rule_name = "required-tags"
    }
  }
}

module "lambda_compliance_report_eventbridge_scheduler" {
  source = "../../../terraform-modules/aws/platform-services/cloudwatch_event/eventbridge_scheduler"
  eventbridge_scheduler_name = "invoke-lambda-compliance-report-daily"
  eventbridge_scheduler_expression = "cron(0 4 * * ? *)"
  eventbridge_scheduler_timezone = "America/New_York"
  flexible_time_window_mode = "FLEXIBLE"
  flexible_maximum_window_in_minutes = 240
  eventbridge_scheduler_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-scb-eventbridge-scheduler-role"
  eventbridge_scheduler_target_arn = module.lambda_function_compliance_report.lambda_function_arn
}

###CPE Approved Security Groups####

module "security_group_prefix" {
  source = "../../../terraform-modules/aws/securitygroup_prefix"
}

module "security_group_http" {
  source = "../../../terraform-modules/aws/securitygroup"
  for_each = toset(data.aws_vpcs.current.ids)
  sg_name = "cpe-allowed-nih-http-sg"
  sg_description = "Security groups allowed by CPE team for http access"
  sg_ingress = local.sg_ingress_http
  sg_egress = var.sg_egress
  assign_vpc_id = "${each.key}"
  sg_tags = var.common_tags
}

module "security_group_https" {
  source = "../../../terraform-modules/aws/securitygroup"
  for_each = toset(data.aws_vpcs.current.ids)
  sg_name = "cpe-allowed-nih-https-sg"
  sg_description = "Security groups allowed by CPE team for https access"
  sg_ingress = local.sg_ingress_https
  sg_egress = var.sg_egress
  assign_vpc_id = "${each.key}"
  sg_tags = var.common_tags
}