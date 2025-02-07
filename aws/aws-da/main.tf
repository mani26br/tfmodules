###S3_tfstate_replication_IAM_role###
module "s3_replication_role"{
  source = "../../terraform-modules/aws/iam/iam_role"
  iam_role_name = "s3_replication_role"
  iam_role_assume_role_policy = data.aws_iam_policy_document.s3_replication_assume_role_policy.json
  iam_role_policy_name = "s3_tfstate_replication_role_policy"
  iam_role_policy = data.aws_iam_policy_document.s3_tfstate_replication_policy.json
  iam_role_tags = var.common_tags
}

##S3_tfstate_replication##
module "S3_replication" {
  source = "../../terraform-modules/aws/platform-services/aws_s3_replication"
  replication_role = module.s3_replication_role.iam_role_arn
  existing_bucket = var.existing_tfstate_bucket_name
  s3_bucket_prefix = var.s3_tfstate_bucket_prefix
  destination_bucket = var.destination_tfstate_bucket_name
  destination_account = var.destination_account_number
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


###config-aggregator###

module "config_aggregator"{
  source = "../../terraform-modules/aws/platform-services/config-aggregator"
  aggregate_organization = true
  config_name = "aws-da-config"
  config_aggregator_name = "aws-da-config-aggregator"
  tags  = var.common_tags
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

module "gd_sns_topic_email_subscription"{
  source = "../../terraform-modules/aws/sns/sns_topic_subscription"
  sns_topic_subscription_topic_arn = module.sns_guardduty_notifications.sns_topic_arn
  sns_topic_subscription_protocol = "email"
  sns_topic_subscription_endpoint =  var.guardduty_subscription_email
}
  
module "aws_guard_duty"{
  source = "../../terraform-modules/aws/platform-services/guard_duty"
  gd_kms_alias_name = var.guardduty_kms_alias_name
  guardduty_logs_s3_bucket = var.guardduty_logs_s3_bucket_name
  tags = var.common_tags
  guarddutyevent_name = var.guardduty_event_name
  notification_arn = module.sns_guardduty_notifications.sns_topic_arn
}

###securityhub###
module "aws_securityhub" {
  source = "../../terraform-modules/aws/platform-services/securityhub/"
}

####AWS_Inspector###
module "aws_inspector"{
  source = "../../terraform-modules/aws/platform-services/aws_inspector"
  current_account_id  = [data.aws_caller_identity.current.account_id]
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

###SGC_AWS_Systems_Manager###

module "aws_ssm_sgc_s3_bucket" {
  source = "../../terraform-modules/aws/platform-services/s3_bucket"
  bucket = var.aws_ssm_sgc_bucket_name
  policy = data.aws_iam_policy_document.aws_ssm_sgc_s3_policy.json
  region = var.AWS_REGION
  bucket_tags = var.common_tags
}

###AWS_System_Manager_ec2_policy###

module "aws_ssm_ec2_iam_policy" {
  source = "../../terraform-modules/aws/iam_policy"
  iam_policy_name = "AmazonSSM_S3_Policy"
  iam_policy_path = "/"
  iam_policy_description = "This policy is used to give ec2 access"
  iam_policy_policy   = data.aws_iam_policy_document.aws_ssm_ec2_policy.json
}