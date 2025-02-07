platform_service_default_group_name = "265129476828-mfa-users"
IAM_role_arn = "arn:aws:iam::265129476828:role/aws-logs-jenkins-pipeline-role"
common_tags = {     
      "project"       = "itrb"
      "environment"   = "prod"
      "access-team"   = "ncats-devops"
}
project_tags = ["ccos", "cd2h", "tin-redcap", "ctai-production"]

###CloudTrail###
aws_cloudtrail_sns_topic_name = "aws-logs-archive-cloudtrail-notifications"
aws_cloudtrail_sqs_name = "aws-logs-archive-cloudtrail-queue"
cloudtrail_s3_bucket = "aws-logs-archive-cloudtrail-s3-bucket"
cloudtrail_kms_alias_name = "alias/cloudtrail_kms_key"
cloudtrail_name = "aws-logs-archive-cloudtrail"
splunk_connection_role_name = "splunk-role-access"

###Config###
aws_config_sns_topic_name = "aws-logs-archive-config-notifications"
config_s3_bucket_name = "aws-logs-archive-config-s3-bucket"
aws_config_sqs_name = "aws-logs-archive-config-queue"

##Guardduty###
guardduty_sns_topic_name = "aws-logs-archive-guardduty-notifications"
guardduty_sqs_name = "aws-logs-archive-guardduty-queue"
guardduty_logs_s3_bucket_name = "aws-logs-archive-guardduty-s3-bucket"
guardduty_event_name = "aws-logs-archive-guardduty-events"
guardduty_subscription_email = "NCATSCPE@mail.nih.gov"
guardduty_kms_alias_name = "alias/guardduty_kms_key"

###VPC_flow_logs###
flowlogrole_name = "aws-logs-archive-vpc-flow-log-role"
flowlogrole_policy_name = "aws-logs-archive-vpc-flow-log-policy"

/*
###DNS_query_logs###
zone_id = ["Z03309881PN2JZ6GGLOJ8", "Z03315913AV5PZHSVDKO5"]
*/

###AWS_System_Manager###
cw_agent_config = <<EOF
  {
	"agent": {
		"run_as_user": "root"
	},
	"logs": {
		"logs_collected": {
			"files": {
				"collect_list": [
					{
						"file_path": "/var/log/syslog", 
						"log_group_name": "/aws/ssm/265129476828/Prod/ec2/syslogs",
						"log_stream_name": "{instance_id}",
						"retention_in_days": -1
					},

          {
						"file_path": "/var/log/audit/audit.log", 
						"log_group_name": "/aws/ssm/265129476828/Prod/ec2/auditlogs",
						"log_stream_name": "{instance_id}",
						"retention_in_days": -1
					}
				]
			}
		}
	}
}
EOF

window_cw_agent_config = <<EOF
  {
  "logs": {
    "logs_collected": {
      "windows_events": {
        "collect_list": [
          {
            "event_format": "xml",
            "event_levels": [
                    "VERBOSE",
                    "INFORMATION",
                    "WARNING",
                    "ERROR",
                    "CRITICAL"
            ],
            "event_name": "System",
            "log_group_name": "/aws/ssm/265129476828/Prod/ec2/syslogs",
            "log_stream_name": "{instance_id}",
            "retention_in_days": -1
            }
          ]
      }
    }
  }
  }
EOF

install_cw_agent_parameters = {
  action = "Install"
  name = "AmazonCloudWatchAgent"
}
configure_cw_agent_parameters = {
  action = "configure (append)"
	mode = "ec2"
	optionalConfigurationSource = "ssm"
	optionalConfigurationLocation = "/cpe/cw-agent/infra/config"
	optionalRestart = "yes"
}
configure_window_cw_agent_parameters = {
  action = "configure (append)"
	mode = "ec2"
	optionalConfigurationSource = "ssm"
	optionalConfigurationLocation = "/cpe/cw-agent/infra/config-window"
	optionalRestart = "yes"
}
status_cw_agent_parameters = {
  action = "status"
	mode = "ec2"
	optionalRestart = "no"
}
status_ssm_agent_parameters = {
  commands = <<EOF
  if systemctl is-active --quiet amazon-ssm-agent; then
    systemctl status amazon-ssm-agent
  elif systemctl is-active --quiet snap.amazon-ssm-agent.amazon-ssm-agent.service; then
    systemctl status snap.amazon-ssm-agent.amazon-ssm-agent.service
  else 
    echo "SSM Agent is not running."
  fi
EOF
}
aws_ssm_bucket_name = "aws-logs-archive-ssm-s3-bucket"

###SGC_AWS_Systems_Manager###
aws_ssm_sgc_bucket_name = "aws-log-archive-snow-sgc-data"

###CloudWatch alerts###
metric_namespace = "CloudWatchAlarms"
cloudtrail_loggroup_name = "/aws/cloudtrail/265129476828/prod/cloudtrail_logs/"
cloudwatchalerts_sns_topic_name = "aws-log-archive-cloudwatchalerts-notifcations"

###S3 Destination bucket for replication###
destination_bucket_name = "aws-platform-services-tfstate-backup"
soruce_account_iam_roles = ["arn:aws:iam::082241233635:role/s3_replication_role", "arn:aws:iam::853771734544:role/s3_replication_role","arn:aws:iam::183580792282:role/s3_replication_role","arn:aws:iam::080246543900:role/s3_replication_role","arn:aws:iam::063208468694:role/s3_replication_role"]

###AWS S3 Access Logs#####
aws_s3_accesslogs_destination_bucket = "aws-logs-s3-accesslogs"
source_logging_bucket = ["aws-logs-tfstate-s3","aws-logs-archive-cloudtrail-s3-bucket"]
accesslogs_sqs_queue_name = "aws-logs-archive-s3-accesslogs-queue"



