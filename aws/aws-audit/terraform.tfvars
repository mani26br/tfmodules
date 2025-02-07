platform_service_default_group_name = "454343540246-mfa-users"
IAM_role_arn = "arn:aws:iam::454343540246:role/aws-audit-jenkins-pipeline-role"
common_tags = {     
      "project"       = "ccos"
      "environment"   = "prod"
      "access-team"   = "ncats-devops"
}


###Config###
aws_config_sqs_name = "aws-audit-config-queue"
config_existing_topic_name = "aws-controltower-AllConfigNotifications"
#config_s3_bucket_name = "aws-config-audit-bucket"


##Guardduty###
guardduty_sns_topic_name = "aws-audit-guardduty-notifications"
guardduty_sqs_name = "aws-audit-guardduty-queue"
guardduty_logs_s3_bucket_name = "aws-audit-guardduty-s3-bucket"
guardduty_event_name = "aws-audit-guardduty-events"
guardduty_subscription_email = "NCATSCPE@mail.nih.gov"
guardduty_kms_alias_name = "alias/guardduty_kms_key"


###VPC_flow_logs###
flowlogrole_name = "aws-audit-vpc-flow-log-role"
flowlogrole_policy_name = "aws-audit-vpc-flow-log-policy"

###DNS_query_logs###
#zone_id = ["Z1034841NXJX3LSKB8MO", "Z04153112MD4V0ZJR1AAR"]

###SGC_AWS_Systems_Manager###
aws_ssm_sgc_bucket_name = "aws-audit-snow-sgc-data"