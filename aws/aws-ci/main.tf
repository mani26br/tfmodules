###S3_tfstate_replication_IAM_role###
module "s3_replication_role"{
  source = "../terraform-modules/aws/iam/iam_role"
  iam_role_name = "s3_replication_role"
  iam_role_assume_role_policy = data.aws_iam_policy_document.s3_replication_assume_role_policy.json
  iam_role_policy_name = "s3_tfstate_replication_role_policy"
  iam_role_policy = data.aws_iam_policy_document.s3_tfstate_replication_policy.json
  iam_role_tags = var.common_tags
}

##S3_tfstate_replication##
module "S3_replication" {
  source = "../terraform-modules/aws/platform-services/aws_s3_replication"
  replication_role = module.s3_replication_role.iam_role_arn
  existing_bucket = var.existing_tfstate_bucket_name
  s3_bucket_prefix = var.s3_tfstate_bucket_prefix
  destination_bucket = var.destination_tfstate_bucket_name
  destination_account = var.destination_account_number
}

###configs###
module "sns_aws_config_notifications"{
  source = "../terraform-modules/aws/sns/sns_topics"
  sns_topic_name = var.aws_config_sns_topic_name
  sns_topic_display_name = var.aws_config_sns_topic_name
  sns_topic_tags = var.common_tags
  sns_topic_policy = data.aws_iam_policy_document.config_sns_topic_policy.json
}

module "sqs_aws_config"{
  source = "../terraform-modules/aws/sqs"
  queue_name = var.aws_config_sqs_name
  sqs_queue_url = module.sqs_aws_config.base_queue_url
  queue_policy = data.aws_iam_policy_document.config_sqs_queue_policy.json
}

module "config_sns_topic_subscription"{
  source = "../terraform-modules/aws/sns/sns_topic_subscription"
  sns_topic_subscription_topic_arn = module.sns_aws_config_notifications.sns_topic_arn
  sns_topic_subscription_protocol = "sqs"
  sns_topic_subscription_endpoint =  module.sqs_aws_config.base_queue_arn
}

module "aws_configrecorder"{
  source = "../terraform-modules/aws/platform-services/configrecorder/"
  aws_config_s3_bucket = var.config_s3_bucket_name
  aws_config_sns_topic_arn = module.sns_aws_config_notifications.sns_topic_arn
  aws_iam_service_linked_role = false
  s3_bucket_tags       = var.common_tags
}

module "aws-NIST-800-53-configrules" {
  source = "../terraform-modules/aws/platform-services/configrules/"
  depends_on = [module.aws_configrecorder]
}

module "aws_required_tags_rule"{
  source = "../terraform-modules/aws/platform-services/configrules/required-tags-rule"
  depends_on = [module.aws_configrecorder]
}

###Guard_Duty###

module "sns_guardduty_notifications"{
  source = "../terraform-modules/aws/sns/sns_topics"
  sns_topic_name = var.guardduty_sns_topic_name
  sns_topic_display_name = var.guardduty_sns_topic_name
  sns_topic_tags = var.common_tags
  sns_topic_policy = data.aws_iam_policy_document.gd_sns_topic_policy.json 
}

module "sqs_guardduty"{
  source = "../terraform-modules/aws/sqs"
  queue_name = var.guardduty_sqs_name
  sqs_queue_url = module.sqs_guardduty.base_queue_url
  queue_policy = data.aws_iam_policy_document.gd_sqs_queue_policy.json 
}

module "gd_sns_topic_subscription"{
  source = "../terraform-modules/aws/sns/sns_topic_subscription"
  sns_topic_subscription_topic_arn = module.sns_guardduty_notifications.sns_topic_arn
  sns_topic_subscription_protocol = "sqs"
  sns_topic_subscription_endpoint =  module.sqs_guardduty.base_queue_arn
}

module "gd_sns_topic_email_subscription"{
  source = "../terraform-modules/aws/sns/sns_topic_subscription"
  sns_topic_subscription_topic_arn = module.sns_guardduty_notifications.sns_topic_arn
  sns_topic_subscription_protocol = "email"
  sns_topic_subscription_endpoint =  var.guardduty_subscription_email
}
  
module "aws_guard_duty"{
  source = "../terraform-modules/aws/platform-services/guard_duty"
  gd_kms_alias_name = var.guardduty_kms_alias_name
  guardduty_logs_s3_bucket = var.guardduty_logs_s3_bucket_name
  tags = var.common_tags
  guarddutyevent_name = var.guardduty_event_name
  notification_arn = module.sns_guardduty_notifications.sns_topic_arn
}

###securityhub###
module "aws_securityhub" {
  source = "../terraform-modules/aws/platform-services/securityhub/"
}

####AWS_Inspector###
module "aws_inspector"{
  source = "../terraform-modules/aws/platform-services/aws_inspector"
  current_account_id  = [data.aws_caller_identity.current.account_id]
}


###VPC_flow_logs###

module "flowlogrole" {
  source = "../terraform-modules/aws/iam/iam_role"
  iam_role_name = var.flowlogrole_name
  iam_role_assume_role_policy = data.aws_iam_policy_document.vpc_flow_assume_role_policy.json
  iam_role_policy_name = var.flowlogrole_policy_name
  iam_role_policy = data.aws_iam_policy_document.flow_log_role_policy.json
}

module "vpc_flowlog" {
  source = "../terraform-modules/aws/platform-services/vpc_flowlog"
  for_each = toset(data.aws_vpcs.current.ids)
  vpc_id = "${each.key}"
  flow_log_role_arn = module.flowlogrole.iam_role_arn
  environment = var.common_tags["environment"]
  cloudwatch_log_tags = var.common_tags
  vpc_flow_log_tags = var.common_tags
}

###DNS_query_logs###
module "dns_query_logs"{
  source = "../terraform-modules/aws/platform-services/dns_query_logs"
  for_each = toset(var.zone_id)
  zone_id = "${each.key}"
  environment = var.common_tags["environment"]
  cloudwatch_log_tags = var.common_tags
}

###AWS_Systems_Manager###

module "aws_ssm_s3_bucket" {
  source = "../terraform-modules/aws/platform-services/s3_bucket"
  bucket = var.aws_ssm_bucket_name
  policy = data.aws_iam_policy_document.aws_ssm_s3_policy.json
  region = var.AWS_REGION
  bucket_tags = var.common_tags
}

module "ssm_InstallCloudWatchAgent" {
  source = "../terraform-modules/aws/platform-services/aws_ssm/aws_ssm_association"
  association_name = "InstallCloudWatchAgent"
  name = "AWS-ConfigureAWSPackage"
  parameters = var.install_cw_agent_parameters
  key = "InstanceIds"
  values = ["*"]
  schedule_expression = "at(2023-08-23T22:00:00)"
  s3_bucket_name = module.aws_ssm_s3_bucket.s3_bucket_name
  s3_key_prefix = "InstallCloudWatchAgent/"
}

###SNOW_SGC_Organization_Role_Policy###

module "aws_ssm_sgc_organization_role" {
  source = "../terraform-modules/aws/iam/iam_role"
  iam_role_name = "SnowOrganizationAccountAccessRole"
  iam_role_assume_role_policy = data.aws_iam_policy_document.sgc_organization_assume_role_policy.json
  iam_role_policy_name = "SnowOrganizationAccountAccessPolicy"
  iam_role_policy = data.aws_iam_policy_document.sgc_organization_role_policy.json
}

###CloudWatchAlerts###

module "cloudwatch_alarms" {
  source ="../terraform-modules/aws/cloudwatch/metric-alarm"
  for_each = local.CloudTrailMetrics
  alarm_name = "${each.key}"
  metric_name = "${each.key}"
  namespace = var.metric_namespace
  alarm_actions = [""]
  tags = var.common_tags
}

module "cloudwatch_log_metric_filter" {
  source ="../terraform-modules/aws/cloudwatch/log-metric-filter"
  for_each = local.CloudTrailMetrics
  log_group_name = [var.cloudtrail_loggroup_name]
  name = "${each.key}"
  metric_transformation_name = "${each.key}"
  pattern = "${each.value}"
  metric_transformation_namespace = var.metric_namespace
}

###AWS S3 Access Logs#####

module "sqs_accesslogs_sqs_queue"{
  source = "../terraform-modules/aws/sqs"
  queue_name = var.accesslogs_sqs_queue_name
  sqs_queue_url = module.sqs_accesslogs_sqs_queue.base_queue_url
  queue_policy = data.aws_iam_policy_document.accesslogs_queue_policy.json 
}

module "aws_s3_accesslogs_destination_bucket" {
  source = "../terraform-modules/aws/platform-services/s3_bucket"
  aws_s3_bucket_object_storage = true
  bucket = var.aws_s3_accesslogs_destination_bucket
  create_aws_s3_bucket_policy = false
  s3_bucket_prefix = "s3accesslogs/"
  bucket_tags = var.common_tags
}

module "aws_s3_accesslogs_notifications" {
  source = "../terraform-modules/aws/platform-services/s3_notifications"
  bucket_prefix = "s3accesslogs/"
  aws_s3_notification_bucket = module.aws_s3_accesslogs_destination_bucket.s3_bucket_name
  aws_s3_bucket_notification_queue = module.sqs_accesslogs_sqs_queue.base_queue_arn
}

module "aws_s3_accesslogs" {
  source = "../terraform-modules/aws/platform-services/s3_access_logs"
  for_each = toset(var.source_logging_bucket)
  source_logging_bucket = "${each.key}"
  target_bucket_name = module.aws_s3_accesslogs_destination_bucket.s3_bucket_name
  target_prefix = "s3accesslogs/"
  depends_on = [module.aws_s3_accesslogs_destination_bucket]
}



###AWS_WAF_logs###
data "aws_wafv2_web_acl" "existing_waf" {
   name  = var.existing_waf
   scope = "CLOUDFRONT"
}
module "aws-waf-logs"{
   source = "../terraform-modules/aws/platform-services/waf-logs"
   existing_waf = data.aws_wafv2_web_acl.existing_waf.name
   create_aws_wafv2_web_acl = false 
   Wafv2_web_acl_arn = data.aws_wafv2_web_acl.existing_waf.arn 
   cloudwatch_log_tags = var.common_tags
}

###Compliance_Report###

module "compliance_report_s3_bucket" {
  source = "../terraform-modules/aws/platform-services/s3_bucket"
  bucket = var.compliance_report_bucket_name
  create_aws_s3_bucket_policy = false
  bucket_tags = var.common_tags
}

module "lambda_compliance_report_role" {
  source = "../terraform-modules/aws/iam/iam_role"
  iam_role_name = var.lambda_compliance_report_role_name
  iam_role_assume_role_policy = data.aws_iam_policy_document.lambda_compliance_report_assume_role_policy.json
  iam_role_policy_name = var.lambda_compliance_report_policy_name
  iam_role_policy = data.aws_iam_policy_document.lambda_compliance_report_role_policy.json
}

module "eventbridge_scheduler_role" {
  source = "../terraform-modules/aws/iam/iam_role"
  iam_role_name = var.eventbridge_scheduler_role_name
  iam_role_assume_role_policy = data.aws_iam_policy_document.eventbridge_scheduler_assume_role_policy.json
  iam_role_policy_name = var.eventbridge_scheduler_role_policy_name
  iam_role_policy = data.aws_iam_policy_document.eventbridge_scheduler_role_policy.json
}

module "lambda_archive_compliance_report" {
  source = "../terraform-modules/aws/lambda/lambda_archive_file"
  lambda_archive_source_dir = "../platform-services/lambda_scripts/compliance_report"
  lambda_archive_output_path = "../platform-services/lambda_scripts/archive/compliance_report.zip"
}

module "lambda_function_compliance_report" {
  source = "../terraform-modules/aws/lambda/lambda_function"
  lambda_function_name = var.lambda_function_compliance_report_name
  lambda_function_description = "Creates compliance report & sends to s3 bucket"
  lambda_function_role = module.lambda_compliance_report_role.iam_role_arn
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
  source = "../terraform-modules/aws/platform-services/cloudwatch_event/eventbridge_scheduler"
  eventbridge_scheduler_name = "invoke-lambda-compliance-report-daily"
  eventbridge_scheduler_expression = "cron(0 4 * * ? *)"
  eventbridge_scheduler_timezone = "America/New_York"
  flexible_time_window_mode = "FLEXIBLE"
  flexible_maximum_window_in_minutes = 240
  eventbridge_scheduler_role_arn = module.eventbridge_scheduler_role.iam_role_arn
  eventbridge_scheduler_target_arn = module.lambda_function_compliance_report.lambda_function_arn
}

###Compliance_Report_User###

module "GetComplianceReportsRole" {
  source = "../terraform-modules/aws/iam/iam_role"
  iam_role_name = "GetComplianceReportsRole"
  iam_role_assume_role_policy = data.aws_iam_policy_document.GetComplianceReportsRole_assumerole_trust_policy.json
  iam_role_policy_name = "AssumeCrossAccountComplianceReportsRole"
  iam_role_policy = data.aws_iam_policy_document.AssumeCrossAccountComplianceReportsRole_policy_permissions.json
  depends_on = [module.compliance_report_user]
}

module "compliance_report_user"{
  source = "../terraform-modules/aws/iam/iam_user/"
  iam_user_name = "compliance-report-user"
  iam_user_tags = var.common_tags
}

module "compliance_report_user_policy"{
  source = "../terraform-modules/aws/iam/iam_user_policy/"
  iam_user_policy_name = "compliance-report-user-policy"
  iam_user = module.compliance_report_user.iam_user_name
  iam_user_policy = data.aws_iam_policy_document.compliance_user_policy.json
  depends_on = [module.GetComplianceReportsRole]
}

###Compliance_Report_Role###

module "compliance_report_role" {
  source = "../terraform-modules/aws/iam/iam_role"
  iam_role_name = "compliance-report-assume-role"
  iam_role_assume_role_policy = data.aws_iam_policy_document.compliance_user_assumerole_trust_policy.json
  iam_role_policy_name = "compliance-report-role-policy"
  iam_role_policy = data.aws_iam_policy_document.compliance_user_role_policy_permissions.json
}


###CPE Approved Security Groups####

module "security_group_prefix" {
  source = "../terraform-modules/aws/securitygroup_prefix"
}

module "security_group_http" {
  source = "../terraform-modules/aws/securitygroup"
  for_each = toset(data.aws_vpcs.current.ids)
  sg_name = ""
  sg_description = "Security groups allowed by CPE team for http access"
  sg_ingress = local.sg_ingress_http
  sg_egress = var.sg_egress
  assign_vpc_id = "${each.key}"
  sg_tags = var.common_tags
}

module "security_group_https" {
  source = "../terraform-modules/aws/securitygroup"
  for_each = toset(data.aws_vpcs.current.ids)
  sg_name = ""
  sg_description = "Security groups allowed by CPE team for https access"
  sg_ingress = local.sg_ingress_https
  sg_egress = var.sg_egress
  assign_vpc_id = "${each.key}"
  sg_tags = var.common_tags
}

module "security_group_ssh" {
  source = "../terraform-modules/aws/securitygroup"
  for_each = toset(data.aws_vpcs.current.ids)
  sg_name = ""
  sg_description = "Security groups allowed by CPE team for ssh access"
  sg_ingress = local.sg_ingress_ssh
  sg_egress = var.sg_egress
  assign_vpc_id = "${each.key}"
  sg_tags = var.common_tags
}

module "security_group_rdp" {
  source = "../terraform-modules/aws/securitygroup"
  for_each = toset(data.aws_vpcs.current.ids)
  sg_name = ""
  sg_description = "Security groups allowed by CPE team for rdp access"
  sg_ingress = local.sg_ingress_rdp
  sg_egress = var.sg_egress
  assign_vpc_id = "${each.key}"
  sg_tags = var.common_tags
}
  
module "EC2_EIC_security_group" {
  source = "../terraform-modules/aws/securitygroup"
  for_each = var.EIC_vpc_ids
  sg_name                  = "cpe-allowed-ec2-instance-ssh-sg"
  sg_description           = "Security groups on EC2 for EIC"
  sg_egress                = var.sg_egress
  assign_vpc_id            = each.value.vpc_id
  sg_tags                  = var.common_tags
}

module "EC2_EIC_security_group_rdp" {
  source = "../terraform-modules/aws/securitygroup"
  for_each = var.EIC_vpc_ids
  sg_name                  = "cpe-allowed-ec2-instance-rdp-sg"
  sg_description           = "Security groups on EC2 for EIC"
  sg_egress                = var.sg_egress
  assign_vpc_id            = each.value.vpc_id
  sg_tags                  = var.common_tags
}

module "EIC_security_group" {
  source = "../terraform-modules/aws/securitygroup"
  depends_on = [module.EC2_EIC_security_group]
  for_each = var.EIC_vpc_ids
  sg_name        = "cpe-allowed-ec2-connect-endpoint-sg"
  sg_description = "Security groups for EC2 instance connect"
  sg_egress = {
    SG = {
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      security_groups = [module.EC2_EIC_security_group[each.key].sg_id]
    }
    SG1 = {
      from_port       = 3389
      to_port         = 3389
      protocol        = "tcp"
      security_groups = [module.EC2_EIC_security_group_rdp[each.key].sg_id]
    }
  }
  assign_vpc_id = each.value.vpc_id
  sg_tags       = var.common_tags
}

module "EC2_EIC_security_group_ingress_rule" {
  source = "../terraform-modules/aws/security_group_ingress_rule"
  depends_on = [module.EIC_security_group]
  for_each = var.EIC_vpc_ids
  sg_ingress_rule_id = module.EC2_EIC_security_group[each.key].sg_id
  referenced_sg_ingress_rule_id = module.EIC_security_group[each.key].sg_id
  sg_ingress_rule_from_port     = 22
  sg_ingress_rule_to_port       = 22 
}

module "EC2_EIC_security_group_ingress_rule_rdp" {
  source = "../terraform-modules/aws/security_group_ingress_rule"
  depends_on = [module.EIC_security_group]
  for_each = var.EIC_vpc_ids
  sg_ingress_rule_id = module.EC2_EIC_security_group_rdp[each.key].sg_id
  referenced_sg_ingress_rule_id = module.EIC_security_group[each.key].sg_id
  sg_ingress_rule_from_port     = 3389
  sg_ingress_rule_to_port       = 3389 
}

###EIC_Endpoint###

module "EIC_assume_role" {
  source = "../terraform-modules/aws/iam/iam_role"
  iam_role_name = "eic-assume-role"
  iam_role_assume_role_policy = data.aws_iam_policy_document.EIC_assume_role_policy.json
  iam_role_policy_name = "eic-policy"
  iam_role_policy = data.aws_iam_policy_document.EIC_role_policy.json
}

module "EC2_EIC" {
  source = "../terraform-modules/aws/vpc_endpoint/ec2_instance_connect"
  depends_on = [module.EIC_security_group]
  for_each = var.EIC_vpc_ids
  ec2_instance_connect_name = "ec2-instance-connect-endpoint-${each.value.vpc_id}"
  ec2_instance_connect_subnet_id = each.value.subnet_ids[0]
  ec2_instance_connect_security_group_id = [module.EIC_security_group[each.key].sg_id]
  ec2_instance_connect_tags = var.common_tags
}

###EIC_SG_Attachment_Lambda_Function####

module "lambda_eic_sg_attachment_role" {
  source = "../terraform-modules/aws/iam/iam_role"
  iam_role_name = var.eic_sg_attachment_role_name
  iam_role_assume_role_policy = data.aws_iam_policy_document.lambda_eic_sg_attachment_assume_role_policy.json
  iam_role_policy_name = var.eic_sg_attachment_policy_name
  iam_role_policy = data.aws_iam_policy_document.eic_sg_attachment_role_policy.json
}

module "lambda_archive_eic_sg_attachment" {
  source = "../terraform-modules/aws/lambda/lambda_archive_file"
  lambda_archive_source_dir = "../platform-services/lambda_scripts/eic_sg_attachment"
  lambda_archive_output_path = "../platform-services/lambda_scripts/archive/eic_sg_attachment.zip"
}

module "lambda_function_eic_sg_attachment" {
  source = "../terraform-modules/aws/lambda/lambda_function"
  lambda_function_name = var.lambda_function_eic_sg_attachment_name
  lambda_function_description = "Attach the eic sg to the ec2 isntances"
  lambda_function_role = module.lambda_eic_sg_attachment_role.iam_role_arn
  lambda_function_runtime = "python3.10"
  lambda_function_layers = [""]
  lambda_function_handler = "eic_sg_attachment.lambda_handler"
  lambda_function_filename = module.lambda_archive_eic_sg_attachment.output_path
  lambda_function_source_code_hash = module.lambda_archive_eic_sg_attachment.hash
  lambda_function_timeout = 600
  lambda_function_memory_size = 1024
  lambda_function_tags = var.common_tags
  environment = {
    variables = {
      security_group_name="cpe-allowed-ec2-instance-ssh-sg"
      region = var.AWS_REGION
      project_values = var.ec2_project_values
    }
  }
}

###SSM_Session###

module "aws_kms_ssm_session" {
  source = "../terraform-modules/aws/platform-services/kms_key"
  description = "Used to encrypt aws system manager sessions"
  alias_name = "ssm_session_kms_key"
  iam_policy = data.aws_iam_policy_document.kms_ssm_session.json
  tags = var.common_tags
}

###SNOW_Mid_Server### 
module "EC2_SNOW_MID_Server" {
  source = "../terraform-modules/aws/ec2"
  instance_name = "snow-ci-cur-win"
  instance_ami = var.mid_server_instance_ami #windows 2019 Full base 
  instance_type = "t3.large"
  instance_subnet = var.mid_server_subnet_id
  instance_keyname = var.mid_server_key
  instance_vpc_sg_ids = [module.EC2_EIC_security_group_rdp["vpc1"].sg_id, module.security_group_rdp["vpc-098b4739cdfffa7ca"].sg_id]
  instance_role = module.SNOW_MID_ec2_role.ec2_profile_name
  appinstance_tags = {     
    "project"       = "snow" 
    "environment"   = ""
    "access-team"   = ""
    "techinical-poc" = ""
    "org" = ""
    "program" = "snow"
  }
}

###SNOW_Mid_Server_Instance_Profile### 

module "SNOW_MID_ec2_role" {
  source = "../terraform-modules/aws/iam/iam_instance_profile"
  ec2_profile_name = "snow-ci-cur-win-role"
  iam_role_name = "snow-ci-cur-win-role"
  role_tags = var.common_tags
}

module "SNOW_MID_CUR_policy" {
  source = "../terraform-modules/aws/iam_policy"
  iam_policy_name = "snow-ci-cur-policy"
  iam_policy_description = "Service Now Mid Server policy for Cost Usage report"
  iam_policy_path = "/"
  iam_policy_policy = data.aws_iam_policy_document.SNOW_MID_CUR_policy.json
}

module "SNOW_MID_CUR_policy_attachment" {
  source = "../terraform-modules/aws/iam/iam_role_policy_attachments"
  depends_on = [module.SNOW_MID_ec2_role]
  role_policy_attachment_role = module.SNOW_MID_ec2_role.ec2_profile_name
  role_policy_attachment_policy_arn = module.SNOW_MID_CUR_policy.iam_policy_arn
}

###Cost-Reports###

module "SNOW_cur_report_s3_bucket" {
  source = "../terraform-modules/aws/platform-services/s3_bucket"
  bucket = var.snow_cur_report_bucket_name
  create_aws_s3_bucket_policy = false
  bucket_tags = var.common_tags
}

module "cost_report_s3_bucket" {
  source = "../terraform-modules/aws/platform-services/s3_bucket"
  bucket = var.cost_report_bucket_name
  create_aws_s3_bucket_policy = false
  bucket_tags = var.common_tags
}

module "lambda_cost_report_role" {
  source = "../terraform-modules/aws/iam/iam_role"
  iam_role_name = var.lambda_cost_report_role_name
  iam_role_assume_role_policy = data.aws_iam_policy_document.lambda_cost_report_assume_role_policy.json
  iam_role_policy_name = var.lambda_cost_report_policy_name
  iam_role_policy = data.aws_iam_policy_document.lambda_cost_report_role_policy.json
}

module "Billing_policy_attachment" {
  source = "../terraform-modules/aws/iam/iam_role_policy_attachments"
  depends_on = [module.lambda_cost_report_role]
  role_policy_attachment_role = module.lambda_cost_report_role.iam_role_name
  role_policy_attachment_policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
}

module "lambda_archive_cost_report" {
  source = "../terraform-modules/aws/lambda/lambda_archive_file"
  lambda_archive_source_dir = "../platform-services/lambda_scripts/cost-usage-report"
  lambda_archive_output_path = "../platform-services/lambda_scripts/archive/resource_cost_usage_report.zip"
}

module "lambda_function_cost_report" {
  source = "../terraform-modules/aws/lambda/lambda_function"
  lambda_function_name = var.lambda_function_cost_report_name
  lambda_function_description = "Creates cost report & sends to s3 bucket"
  lambda_function_role = module.lambda_cost_report_role.iam_role_arn
  lambda_function_runtime = "python3.10"
  lambda_function_layers = [""]
  lambda_function_handler = "resource_cost_usage_report.lambda_handler"
  lambda_function_filename = module.lambda_archive_cost_report.output_path
  lambda_function_source_code_hash = module.lambda_archive_cost_report.hash
  lambda_function_timeout = 600
  lambda_function_memory_size = 1024
  lambda_function_tags = var.common_tags
  environment = {
    variables = {
      BUCKET_NAME = var.cost_report_bucket_name
      ACCESS_TEAM_LIST = var.ACCESS_TEAM_LIST
      PROGRAMS_MAP = var.PROGRAM_PROJECT_MAP
    }
  }
}

module "lambda_cost_report_eventbridge_scheduler" {
  source = "../terraform-modules/aws/platform-services/cloudwatch_event/eventbridge_scheduler"
  eventbridge_scheduler_name = "invoke-lambda-cost-report-bi-weekly"
  eventbridge_scheduler_expression = "rate(14 days)"
  eventbridge_scheduler_timezone = "America/New_York"
  eventbridge_scheduler_role_arn = module.eventbridge_scheduler_role.iam_role_arn
  eventbridge_scheduler_target_arn = module.lambda_function_cost_report.lambda_function_arn
}

###Budget_Reports###

module "budgets" {
  source = "../terraform-modules/aws/platform-services/aws_budget"
  budgets = local.budgets_by_program
}

###AWS_Maintenance_Window_Start/Stop_EC2###

###Lambda_Start/Stop_notification###

module "lambda_start_stop_role" {
  source = "../terraform-modules/aws/iam/iam_role"
  iam_role_name = var.lambda_start_stop_role_name
  iam_role_assume_role_policy = data.aws_iam_policy_document.lambda_start_stop_assume_role_policy.json
  iam_role_policy_name = var.lambda_start_stop_policy_name
  iam_role_policy = data.aws_iam_policy_document.lambda_start_stop_role_policy.json
}

module "lambda_archive_mw" {
  source = "../terraform-modules/aws/lambda/lambda_archive_file"
  lambda_archive_source_dir = "../platform-services/lambda_scripts/maintenance"
  lambda_archive_output_path = "../platform-services/lambda_scripts/archive/maintenance.zip"
}

module "lambda_function_sns_mw" {
  source = "../terraform-modules/aws/lambda/lambda_function"
  lambda_function_name = var.lambda_start_stop_notificaiton_name
  lambda_function_description = "sns email notificaiton for start/stop maintenance task"
  lambda_function_layers = [""]
  lambda_function_role = module.lambda_start_stop_role.iam_role_arn
  lambda_function_runtime = "python3.11"
  lambda_function_handler = "sns_mw_notification.lambda_handler"
  lambda_function_filename = module.lambda_archive_mw.output_path
  lambda_function_source_code_hash = module.lambda_archive_mw.hash
  lambda_function_timeout = 300
  lambda_function_tags = var.common_tags
  environment = {
    variables = {
      ENVIRONMENT = "dev"
      ACCOUNT = "aws-ci"
      TIMEZONE = "US/Eastern"
    }
  }
}

###Maintenance_window_automation_role###

module "aws_ssm_automation_role" {
  source = "../terraform-modules/aws/iam/iam_role"
  iam_role_name = "start-stop-ec2-automation-role"
  iam_role_assume_role_policy = data.aws_iam_policy_document.automation_assume_role_policy.json
  iam_role_policy_name = "StartStopAutomationPolicy"
  iam_role_policy = data.aws_iam_policy_document.automation_role_policy.json
}

###Maintenance_window###

module "ssm_mw_start" {
  source = "../terraform-modules/aws/platform-services/aws_ssm/aws_ssm_maintenance_window/window"
  name            = "window-start-ec2"
  schedule        = "cron(0 11 ? * MON-FRI *)"
  duration        = 2
  cutoff          = 1
  tags = var.common_tags
}

module "ssm_mw_stop" {
  source = "../terraform-modules/aws/platform-services/aws_ssm/aws_ssm_maintenance_window/window"
  name            = "window-stop-ec2"
  schedule        = "cron(0 3 ? * TUE-SAT *)"
  duration        = 2
  cutoff          = 1
  tags = var.common_tags
}

####Maintenance_window_targets###

module "ssm_mw_target_agm" {
  depends_on = [ module.ssm_mw_start, module.ssm_mw_stop ]
  for_each = toset([module.ssm_mw_start.maintenance_window_id, module.ssm_mw_stop.maintenance_window_id])
  source = "../terraform-modules/aws/platform-services/aws_ssm/aws_ssm_maintenance_window/window_target"
  window_id = each.value
  name          = "maintenance-window-target-agm"
  description   = "This is a maintenance window target for agm program"
  resource_type = "RESOURCE_GROUP"
  key = "resource-groups:Name"
  values = ["Program-agm"]
}

module "ssm_mw_target_aspire" {
  depends_on = [ module.ssm_mw_start, module.ssm_mw_stop ]
  for_each = toset([module.ssm_mw_start.maintenance_window_id, module.ssm_mw_stop.maintenance_window_id])
  source = "../terraform-modules/aws/platform-services/aws_ssm/aws_ssm_maintenance_window/window_target"
  window_id = each.value
  name          = "maintenance-window-target-aspire"
  description   = "This is a maintenance window target for aspire program"
  resource_type = "RESOURCE_GROUP"
  key = "resource-groups:Name"
  values = ["Program-aspire"]
}

module "ssm_mw_target_gard" {
  depends_on = [ module.ssm_mw_start, module.ssm_mw_stop ]
  for_each = toset([module.ssm_mw_start.maintenance_window_id, module.ssm_mw_stop.maintenance_window_id])
  source = "../terraform-modules/aws/platform-services/aws_ssm/aws_ssm_maintenance_window/window_target"
  window_id = each.value
  name          = "maintenance-window-target-gard"
  description   = "This is a maintenance window target for gard program"
  resource_type = "RESOURCE_GROUP"
  key = "resource-groups:Name"
  values = ["Program-gard"]
}

module "ssm_mw_target_project-tracking" {
  depends_on = [ module.ssm_mw_start, module.ssm_mw_stop ]
  for_each = toset([module.ssm_mw_start.maintenance_window_id, module.ssm_mw_stop.maintenance_window_id])
  source = "../terraform-modules/aws/platform-services/aws_ssm/aws_ssm_maintenance_window/window_target"
  window_id = each.value
  name          = "maintenance-window-target-project-tracking"
  description   = "This is a maintenance window target for program-tracking program"
  resource_type = "RESOURCE_GROUP"
  key = "resource-groups:Name"
  values = ["Program-project-tracking"]
}

###Maintenance_tasks###

module "ssm_mw_automation_task_start" {
  source = "../terraform-modules/aws/platform-services/aws_ssm/aws_ssm_maintenance_window/window_task/automation"
  window_id = module.ssm_mw_start.maintenance_window_id
  name = "StartEC2Instances"
  max_concurrency = 10
  task_arn        = "AWS-StartEC2Instance"
  window_target_ids_values = [module.ssm_mw_target_agm[module.ssm_mw_start.maintenance_window_id].maintenance_window_target_id, module.ssm_mw_target_aspire[module.ssm_mw_start.maintenance_window_id].maintenance_window_target_id, module.ssm_mw_target_aspire[module.ssm_mw_start.maintenance_window_id].maintenance_window_target_id, module.ssm_mw_target_gard[module.ssm_mw_start.maintenance_window_id].maintenance_window_target_id, module.ssm_mw_target_project-tracking[module.ssm_mw_start.maintenance_window_id].maintenance_window_target_id]
  service_role_arn = module.aws_ssm_automation_role.iam_role_arn
  priority = 0
  parameter = local.MaintenanceWindow_resource_group
}

module "ssm_mw_lambda_start_notification" {
  for_each = var.start_ssm_mw_payloads
  source = "../terraform-modules/aws/platform-services/aws_ssm/aws_ssm_maintenance_window/window_task/lambda"
  window_id = module.ssm_mw_start.maintenance_window_id
  name = each.key
  task_arn        = module.lambda_function_sns_mw.lambda_function_arn
  create_targets = false
  service_role_arn = module.aws_ssm_automation_role.iam_role_arn
  priority = 1
  payload = each.value
}

module "ssm_mw_automation_task_stop" {
  source = "../terraform-modules/aws/platform-services/aws_ssm/aws_ssm_maintenance_window/window_task/automation"
  window_id = module.ssm_mw_stop.maintenance_window_id
  name = "StopEC2Instances"
  max_concurrency = 10
  task_arn        = "AWS-StopEC2Instance"
  window_target_ids_values = [module.ssm_mw_target_agm[module.ssm_mw_stop.maintenance_window_id].maintenance_window_target_id, module.ssm_mw_target_aspire[module.ssm_mw_stop.maintenance_window_id].maintenance_window_target_id, module.ssm_mw_target_aspire[module.ssm_mw_stop.maintenance_window_id].maintenance_window_target_id, module.ssm_mw_target_gard[module.ssm_mw_stop.maintenance_window_id].maintenance_window_target_id, module.ssm_mw_target_project-tracking[module.ssm_mw_stop.maintenance_window_id].maintenance_window_target_id]
  service_role_arn = module.aws_ssm_automation_role.iam_role_arn
  priority = 0
  parameter = local.MaintenanceWindow_resource_group
}

module "ssm_mw_lambda_stop_notification" {
  for_each = var.stop_ssm_mw_payloads
  source = "../terraform-modules/aws/platform-services/aws_ssm/aws_ssm_maintenance_window/window_task/lambda"
  window_id = module.ssm_mw_stop.maintenance_window_id
  name = each.key
  task_arn        = module.lambda_function_sns_mw.lambda_function_arn
  create_targets = false
  service_role_arn = module.aws_ssm_automation_role.iam_role_arn
  priority = 1
  payload = each.value
}
