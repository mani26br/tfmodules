aws_config_sns_topic_name = ""
config_s3_bucket_name = ""
aws_config_sqs_name = ""

guardduty_sns_topic_name = ""
guardduty_sqs_name = ""
guardduty_logs_s3_bucket_name = ""
guardduty_event_name = ""
guardduty_subscription_email = ""
guardduty_kms_alias_name = ""

flowlogrole_name = ""
flowlogrole_policy_name = ""

zone_id = [""]

aws_ssm_bucket_name = ""

metric_namespace = ""
cloudtrail_loggroup_name = ""

aws_s3_accesslogs_destination_bucket = ""
source_logging_bucket = ["", ""]
accesslogs_sqs_queue_name = ""

attached_albs = [
  "",
  "",
  ""
]
existing_waf = ""
cloudfront_distribution_ids = ["", "", ""]

compliance_report_bucket_name = ""
lambda_compliance_report_role_name = ""
lambda_compliance_report_policy_name = ""
lambda_function_compliance_report_name = ""
compliance_report_name = ""
eventbridge_scheduler_role_name = ""
eventbridge_scheduler_role_policy_name = ""

compliance_report_assume_roles = [

]

sg_egress = {
  SG = {
    from_port = 0
    to_port = 0
    protocol = ""
    cidr_blocks = [""]
  }
}

eic_sg_attachment_role_name = ""
eic_sg_attachment_policy_name = ""
lambda_function_eic_sg_attachment_name = ""
ec2_project_values = ""

mid_server_instance_ami = ""
mid_server_subnet_id = ""
mid_server_key = ""

snow_cur_report_bucket_name = ""
cost_report_bucket_name = ""
lambda_cost_report_role_name = ""
lambda_cost_report_policy_name = ""
lambda_function_cost_report_name = ""
cost_report_name = ""
ACCESS_TEAM_LIST = ""

lambda_start_stop_role_name = ""
lambda_start_stop_policy_name = ""
lambda_start_stop_notificaiton_name = ""
