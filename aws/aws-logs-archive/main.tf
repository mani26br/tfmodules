###S3 Destination bucket for replication###
module "tfstate_destination_s3_bucket" {
  source = "../../terraform-modules/aws/platform-services/s3_bucket"
  bucket = var.destination_bucket_name
  policy = data.aws_iam_policy_document.destination_s3_policy.json
  create_aws_s3_bucket_acl = false
  object_ownership = "BucketOwnerEnforced"
  region = var.AWS_REGION
  bucket_tags = var.common_tags
}

###CloudTrail###
module "sns_aws_cloudtrail_notifications"{
  source = "../../terraform-modules/aws/sns/sns_topics"
  sns_topic_name = var.aws_cloudtrail_sns_topic_name
  sns_topic_display_name = var.aws_cloudtrail_sns_topic_name
  sns_topic_tags = var.common_tags
  sns_topic_policy = data.aws_iam_policy_document.cloudtrail_sns_topic_policy.json
}

module "sqs_aws_cloudtrail"{
  source = "../../terraform-modules/aws/sqs"
  queue_name = var.aws_cloudtrail_sqs_name
  sqs_queue_url = module.sqs_aws_cloudtrail.base_queue_url
  queue_policy = data.aws_iam_policy_document.cloudtrail_sqs_queue_policy.json
}

module "cloudtrail_sns_topic_subscription"{
  source = "../../terraform-modules/aws/sns/sns_topic_subscription"
  sns_topic_subscription_topic_arn = module.sns_aws_cloudtrail_notifications.sns_topic_arn
  sns_topic_subscription_protocol = "sqs"
  sns_topic_subscription_endpoint =  module.sqs_aws_cloudtrail.base_queue_arn
}

module "aws_cloudtrail"{
  source = "../../terraform-modules/aws/platform-services/cloudtrail"
  aws_cloudtrail_bucket = var.cloudtrail_s3_bucket
  s3_bucket_tags = var.common_tags
  environment = var.common_tags["environment"]
  cloudtrail_tags = var.common_tags
  cloudtrail_alias_name = var.cloudtrail_kms_alias_name
  trail_name = var.cloudtrail_name
  aws_splunk_role_name = var.splunk_connection_role_name
  sns_topic_name = var.aws_cloudtrail_sns_topic_name
}

###configs###
module "sns_aws_config_notifications"{
  source = "../../terraform-modules/aws/sns/sns_topics"
  sns_topic_name = var.aws_config_sns_topic_name
  sns_topic_display_name = var.aws_config_sns_topic_name
  sns_topic_tags = var.common_tags
  sns_topic_policy = data.aws_iam_policy_document.config_sns_topic_policy.json
}

module "sqs_aws_config"{
  source = "../../terraform-modules/aws/sqs"
  queue_name = var.aws_config_sqs_name
  sqs_queue_url = module.sqs_aws_config.base_queue_url
  queue_policy = data.aws_iam_policy_document.config_sqs_queue_policy.json
}

module "config_sns_topic_subscription"{
  source = "../../terraform-modules/aws/sns/sns_topic_subscription"
  sns_topic_subscription_topic_arn = module.sns_aws_config_notifications.sns_topic_arn
  sns_topic_subscription_protocol = "sqs"
  sns_topic_subscription_endpoint =  module.sqs_aws_config.base_queue_arn
}


module "aws_configrecorder"{
  source = "../../terraform-modules/aws/platform-services/configrecorder/"
  aws_config_s3_bucket = var.config_s3_bucket_name
  aws_config_sns_topic_arn = module.sns_aws_config_notifications.sns_topic_arn
  aws_iam_service_linked_role = true
  s3_bucket_tags       = var.common_tags
}

module "aws-NIST-800-53-configrules" {
  source = "../../terraform-modules/aws/platform-services/configrules/"
  depends_on = [module.aws_configrecorder]
}

module "aws_required_tags_rule"{
  source = "../../terraform-modules/aws/platform-services/configrules/required-tags-rule"
  depends_on = [module.aws_configrecorder]
}

###Guard_Duty###

module "sns_guardduty_notifications"{
  source = "../../terraform-modules/aws/sns/sns_topics"
  sns_topic_name = var.guardduty_sns_topic_name
  sns_topic_display_name = var.guardduty_sns_topic_name
  sns_topic_tags = var.common_tags
  sns_topic_policy = data.aws_iam_policy_document.gd_sns_topic_policy.json 
}

module "sqs_guardduty"{
  source = "../../terraform-modules/aws/sqs"
  queue_name = var.guardduty_sqs_name
  sqs_queue_url = module.sqs_guardduty.base_queue_url
  queue_policy = data.aws_iam_policy_document.gd_sqs_queue_policy.json 
}

module "gd_sns_topic_subscription"{
  source = "../../terraform-modules/aws/sns/sns_topic_subscription"
  sns_topic_subscription_topic_arn = module.sns_guardduty_notifications.sns_topic_arn
  sns_topic_subscription_protocol = "sqs"
  sns_topic_subscription_endpoint =  module.sqs_guardduty.base_queue_arn
}
  
module "aws_guard_duty"{
  source = "../../terraform-modules/aws/platform-services/guard_duty"
  gd_kms_alias_name = var.guardduty_kms_alias_name
  guardduty_logs_s3_bucket = var.guardduty_logs_s3_bucket_name
  tags = var.common_tags
  guarddutyevent_name = var.guardduty_event_name
  notification_arn = module.sns_guardduty_notifications.sns_topic_arn
}

module "gd_sns_topic_email_subscription"{
  source = "../../terraform-modules/aws/sns/sns_topic_subscription"
  sns_topic_subscription_topic_arn = module.sns_guardduty_notifications.sns_topic_arn
  sns_topic_subscription_protocol = "email"
  sns_topic_subscription_endpoint =  var.guardduty_subscription_email
}

###securityhub###
module "aws_securityhub" {
  source = "../../terraform-modules/aws/platform-services/securityhub/"
}

###VPC_flow_logs###

module "flowlogrole" {
  source = "../../terraform-modules/aws/iam/iam_role"
  iam_role_name = var.flowlogrole_name
  iam_role_assume_role_policy = data.aws_iam_policy_document.vpc_flow_assume_role_policy.json
  iam_role_policy_name = var.flowlogrole_policy_name
  iam_role_policy = data.aws_iam_policy_document.flow_log_role_policy.json
}

module "vpc_flowlog" {
  source = "../../terraform-modules/aws/platform-services/vpc_flowlog"
  for_each = toset(data.aws_vpcs.current.ids)
  vpc_id = "${each.key}"
  flow_log_role_arn = module.flowlogrole.iam_role_arn
  environment = var.common_tags["environment"]
  cloudwatch_log_tags = var.common_tags
  vpc_flow_log_tags = var.common_tags
}

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

###AWS_Systems_Manager###

module "ec2_iam_policy" {
  source = "../../terraform-modules/aws/iam_policy"
  iam_policy_name = "AmazonSSM_S3_Policy"
  iam_policy_path = "/"
  iam_policy_description = "This policy is used to give ec2 access to publish to S3 & CloudWatch logs"
  iam_policy_policy   = data.aws_iam_policy_document.aws_ssm_ec2_policy.json
}

module "aws_ssm_s3_bucket" {
  source = "../../terraform-modules/aws/platform-services/s3_bucket"
  bucket = var.aws_ssm_bucket_name
  policy = data.aws_iam_policy_document.aws_ssm_s3_policy.json
  region = var.AWS_REGION
  bucket_tags = var.common_tags
}

module "ssm_InstallCloudWatchAgent" {
  source = "../../terraform-modules/aws/platform-services/aws_ssm/aws_ssm_association"
  association_name = "InstallCloudWatchAgent"
  name = "AWS-ConfigureAWSPackage"
  parameters = var.install_cw_agent_parameters
  key = "tag:project"
  values = var.project_tags
  schedule_expression = "at(2023-08-24T17:40:00)"
  s3_bucket_name = module.aws_ssm_s3_bucket.s3_bucket_name
  s3_key_prefix = "InstallCloudWatchAgent/"  
}

module "ssm_parameter_store_cwa_config" {
    source = "../../terraform-modules/aws/platform-services/aws_ssm/aws_ssm_parameter"
    name = "/cpe/cw-agent/infra/config"
    description = "configuration file for cloudwatch agent"
    type = "String"
    value = var.cw_agent_config
    tags = var.common_tags
}

module "ssm_ConfigureCloudWatchAgent" {
  source = "../../terraform-modules/aws/platform-services/aws_ssm/aws_ssm_association"
  association_name = "ConfigureCloudWatchAgent"
  name = "AmazonCloudWatch-ManageAgent"
  parameters = var.configure_cw_agent_parameters
  key = "tag:project"
  values = var.project_tags
  schedule_expression = "at(2023-08-24T17:42:00)"
  s3_bucket_name = module.aws_ssm_s3_bucket.s3_bucket_name
  s3_key_prefix = "ConfigureCloudWatchAgent/"
}

module "ssm_parameter_store_window_cwa_config" {
    source = "../../terraform-modules/aws/platform-services/aws_ssm/aws_ssm_parameter"
    name = "/cpe/cw-agent/infra/config-window"
    description = "configuration file for cloudwatch agent"
    type = "String"
    value = var.window_cw_agent_config
    tags = var.common_tags
}

module "ssm_Window_ConfigureCloudWatchAgent" {
  source = "../../terraform-modules/aws/platform-services/aws_ssm/aws_ssm_association"
  association_name = "Window_ConfigureCloudWatchAgent"
  name = "AmazonCloudWatch-ManageAgent"
  parameters = var.configure_window_cw_agent_parameters
  key = "tag:OS"
  values = ["Windows"]
  schedule_expression = "at(2023-08-25T14:25:00)"
  s3_bucket_name = module.aws_ssm_s3_bucket.s3_bucket_name
  s3_key_prefix = "ConfigureCloudWatchAgent/"
}

module "ssm_CloudWatchAgentStatus" {
  source = "../../terraform-modules/aws/platform-services/aws_ssm/aws_ssm_association"
  association_name = "CloudWatchAgentStatus"
  name = "AmazonCloudWatch-ManageAgent"
  parameters = var.status_cw_agent_parameters
  key = "tag:project"
  values = var.project_tags
  schedule_expression = "at(2023-08-30T21:10:00)"
  s3_bucket_name = module.aws_ssm_s3_bucket.s3_bucket_name 
  s3_key_prefix = "CloudWatchAgentStatus/"
}

module "ssm_SsmAgentStatus" {
  source = "../../terraform-modules/aws/platform-services/aws_ssm/aws_ssm_association"
  association_name = "SsmAgentStatus"
  name = "AWS-RunShellScript"
  parameters = var.status_ssm_agent_parameters
  key = "tag:project"
  values = var.project_tags
  schedule_expression = "at(2023-09-22T19:30:00)"
  s3_bucket_name = module.aws_ssm_s3_bucket.s3_bucket_name 
  s3_key_prefix = "SsmAgentStatus/"
}

###SGC_AWS_Systems_Manager###

module "aws_ssm_sgc_s3_bucket" {
  source = "../../terraform-modules/aws/platform-services/s3_bucket"
  bucket = var.aws_ssm_sgc_bucket_name
  policy = data.aws_iam_policy_document.aws_ssm_sgc_s3_policy.json
  region = var.AWS_REGION
  bucket_tags = var.common_tags
}

###CloudWatchAlerts###

module "cloudwatch_alarms" {
  source ="../../terraform-modules/aws/cloudwatch/metric-alarm"
  for_each = local.CloudTrailMetrics
  alarm_name = "${each.key}"
  metric_name = "${each.key}"
  namespace = var.metric_namespace
  alarm_actions = [module.sns_cloudwatchalerts_notifications.sns_topic_arn]
  tags = var.common_tags
}

module "cloudwatch_log_metric_filter" {
  source ="../../terraform-modules/aws/cloudwatch/log-metric-filter"
  for_each = local.CloudTrailMetrics
  log_group_name = [var.cloudtrail_loggroup_name]
  name = "${each.key}"
  metric_transformation_name = "${each.key}"
  pattern = "${each.value}"
  metric_transformation_namespace = var.metric_namespace
}

module "sns_cloudwatchalerts_notifications" {
  source = "../../terraform-modules/aws/sns/sns_topics"
  sns_topic_name = var.cloudwatchalerts_sns_topic_name
  sns_topic_display_name = var.cloudwatchalerts_sns_topic_name
  sns_topic_tags = var.common_tags
  sns_topic_policy = data.aws_iam_policy_document.cwa_sns_topic_policy.json
}

module "cwa_email_sns_topic_subscription"{
  source = "../../terraform-modules/aws/sns/sns_topic_subscription"
  sns_topic_subscription_topic_arn = module.sns_cloudwatchalerts_notifications.sns_topic_arn
  sns_topic_subscription_protocol = "email"
  sns_topic_subscription_endpoint = "NCATSCPE@mail.nih.gov"
}

####AWS_Inspector###

module "aws_inspector"{
  source = "../../terraform-modules/aws/platform-services/aws_inspector"
  current_account_id  = [data.aws_caller_identity.current.account_id]
}

###AWS S3 Access Logs#####

module "sqs_accesslogs_sqs_queue"{
  source = "../../terraform-modules/aws/sqs"
  queue_name = var.accesslogs_sqs_queue_name
  sqs_queue_url = module.sqs_accesslogs_sqs_queue.base_queue_url
  queue_policy = data.aws_iam_policy_document.accesslogs_queue_policy.json 
}

module "aws_s3_accesslogs_destination_bucket" {
  source = "../../terraform-modules/aws/platform-services/s3_bucket"
  aws_s3_bucket_object_storage = true
  bucket = var.aws_s3_accesslogs_destination_bucket
  create_aws_s3_bucket_policy = false
  s3_bucket_prefix = "s3accesslogs/"
  bucket_tags = var.common_tags
}

module "aws_s3_accesslogs_notifications" {
  source = "../../terraform-modules/aws/platform-services/s3_notifications"
  bucket_prefix = "s3accesslogs/"
  aws_s3_notification_bucket = module.aws_s3_accesslogs_destination_bucket.s3_bucket_name
  aws_s3_bucket_notification_queue = module.sqs_accesslogs_sqs_queue.base_queue_arn
}

module "aws_s3_accesslogs" {
  source = "../../terraform-modules/aws/platform-services/s3_access_logs"
  for_each = toset(var.source_logging_bucket)
  source_logging_bucket = "${each.key}"
  target_bucket_name = module.aws_s3_accesslogs_destination_bucket.s3_bucket_name
  target_prefix = "s3accesslogs/"
  depends_on = [module.aws_s3_accesslogs_destination_bucket]
}

###SNOW_SGC_Organization_Role_Policy###

module "aws_ssm_sgc_organization_role" {
  source = "../../terraform-modules/aws/iam/iam_role"
  iam_role_name = "SnowOrganizationAccountAccessRole"
  iam_role_assume_role_policy = data.aws_iam_policy_document.sgc_organization_assume_role_policy.json
  iam_role_policy_name = "SnowOrganizationAccountAccessPolicy"
  iam_role_policy = data.aws_iam_policy_document.sgc_organization_role_policy.json
}



