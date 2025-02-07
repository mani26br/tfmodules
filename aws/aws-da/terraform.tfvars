platform_service_default_group_name = "082241233635-mfa-users"
IAM_role_arn = "arn:aws:iam::082241233635:role/aws-da-jenkins-pipeline-role"
common_tags = {     
      "project"       = "itrb"
      "environment"   = "prod"
      "access-team"   = "ncats-devops"
}

###S3_tfstate_replication###
existing_tfstate_bucket_name = "aws-da-tfstate-s3"
s3_tfstate_bucket_prefix = "platform-services"
destination_tfstate_bucket_name = "aws-platform-services-tfstate-backup"
destination_account_number = "265129476828"

###Config###
aws_config_sns_topic_name = "aws-da-config-notifications"
config_s3_bucket_name = "aws-da-config-s3-bucket"
aws_config_sqs_name = "aws-da-config-queue"

##Guardduty###
guardduty_sns_topic_name = "aws-da-guardduty-notifications"
guardduty_sqs_name = "aws-da-guardduty-queue"
guardduty_logs_s3_bucket_name = "aws-da-guardduty-s3-bucket"
guardduty_event_name = "aws-da-guardduty-events"
guardduty_subscription_email = "NCATSCPE@mail.nih.gov"
guardduty_kms_alias_name = "alias/guardduty_kms_key"

###VPC_flow_logs###
flowlogrole_name = "aws-da-vpc-flow-log-role"
flowlogrole_policy_name = "aws-da-vpc-flow-log-policy"

###DNS_query_logs###
#zone_id = ["Z093019012EVBLYSN4QQP", "Z38V3QYVHLCI7U", "Z07779682IZ0ACSW0FU91", "Z303PWPCGVW2WO", "Z04991063IGNGY40F9E26"]

###SGC_AWS_Systems_Manager###
aws_ssm_sgc_bucket_name = "aws-da-snow-sgc-data"