platform_service_default_group_name = "183580792282-mfa-users"
IAM_role_arn = "arn:aws:iam::183580792282:role/aws-prod-jenkins-pipeline-role"
common_tags = {     
      "project"       = "management-services"
      "environment"   = "prod"
      "access-team"   = "ncats-devops"
}

###S3_tfstate_replication###
existing_tfstate_bucket_name = "aws-prod-tfstate-s3"
s3_tfstate_bucket_prefix = "platform-services"
destination_tfstate_bucket_name = "aws-platform-services-tfstate-backup"
destination_account_number = "265129476828"

###Config###
aws_config_sns_topic_name = "aws-prod-config-notifications"
config_s3_bucket_name = "aws-prod-config-s3-bucket"
aws_config_sqs_name = "aws-prod-config-queue"

##Guardduty###
guardduty_sns_topic_name = "aws-prod-gurardduty-notifications"
guardduty_sqs_name = "aws-prod-guardduty-queue"
guardduty_logs_s3_bucket_name = "aws-prod-gurdduty-s3-bucket"
guardduty_event_name = "aws-prod-guardduty-events"
guardduty_subscription_email = "NCATSCPE@mail.nih.gov"
guardduty_kms_alias_name = "alias/guardduty_kms_key"

###VPC_flow_logs###
flowlogrole_name = "aws-prod-vpc-flow-log-role"
flowlogrole_policy_name = "aws-prod-vpc-flow-log-policy"

###DNS_query_logs###
zone_id = ["Z10155682BAGSNAX55YFJ", "Z00221582JP7TE0IUYBA3"]

###SGC_AWS_Systems_Manager###
aws_ssm_sgc_bucket_name = "aws-prod-snow-sgc-data"
document_content = <<DOC
  {
    "schemaVersion": "2.2",
    "description": "Service Graph AWS - aws:runShellScript",
    "mainSteps": [
      {
        "inputs": {
          "timeoutSeconds": "3600",
          "runCommand": [
            "echo '####SG-AWS-06-02-2022####'",
            "dmidecode system | grep -E '(Manufacturer|Product Name|Serial Number)'| sed 's/^/#DMI#/'",
            "ps awwxo pid,ppid,command | sed 's/^/#PS#/'",
            "netstat -anpt | sed 's/^/#NETSTAT#/'",
            "grep -E '(model name|vendor_id|cpu MHz|cpu cores)' /proc/cpuinfo | sed 's/^/#CPU#/'",
            "awk '/MemTotal/ {print $2}' /proc/meminfo | sed 's/^/#RAM-KB#/'",
            "lsblk -dn | grep -v '^loop' | sed 's/^/#DISK#/'"
            ]
            },
            "name": "runShellScript",
            "action": "aws:runShellScript"
      }
    ]
  }
DOC
windows_document_content = <<DOC
{
  "schemaVersion": "2.2",
  "description": "Service Graph AWS - aws:runPowerShellScript",
  "mainSteps": [
    {
      "inputs": {
        "timeoutSeconds": "3600",
        "runCommand": [
          "echo '####SG-AWS-06-02-2022####'",
          "echo '####-WINDOWS-####'",
          "wmic bios get serialnumber | foreach {\"###SERIAL###\"+ $_}",
          "netstat -anop TCP | foreach {\"###TCP###\"+ $_}",
          "cmd /a /c 'wmic computersystem get model,name,systemtype,manufacturer,DNSHostName,domain,TotalPhysicalMemory,NumberOfProcessors /format:list' | foreach {\"###CS###\"+ $_}",
          "cmd /a /c 'wmic cpu get Manufacturer,MaxClockSpeed,DeviceID,Name,Caption /format:list' | foreach {\"###CPU###\"+ $_}",
          "cmd /a /c 'wmic process get ProcessId, ParentProcessId, Name, ExecutablePath, Description, CommandLine /format:rawxml' | foreach {\"###PS###\"+ $_}",
          "(Get-Disk | measure-object -Property size -Sum).Sum / 1GB | foreach {\"###DISK###\"+ $_}",
          "(Get-WmiObject Win32_PhysicalMemory | measure-object Capacity -sum).sum/1gb | foreach {\"###RAM-GB###\"+ $_}"
        ]
      },
      "name": "runPowerShellScript",
      "action": "aws:runPowerShellScript"
    }
  ]
}
DOC

###AWS S3 Access Logs#####
aws_s3_accesslogs_destination_bucket = "aws-prod-s3-accesslogs"
source_logging_bucket = ["aws-prod-tfstate-s3","aws-ncats-prod-cloudtrail"]
accesslogs_sqs_queue_name = "aws-prod-s3-accesslogs-queue"

###Compliance_Report###
compliance_report_bucket_name = "aws-prod-compliance-report-s3-bucket"
lambda_compliance_report_role_name = "aws-prod-compliance-report-role"
lambda_compliance_report_policy_name = "aws-prod-compliance-report-policy"
lambda_function_compliance_report_name = "aws-prod-compliance-report-function"
compliance_report_name = "aws-prod_required-tags_non-compliant_all-resources"
eventbridge_scheduler_role_name = "aws-prod-eventbridge-scheduler-role"
eventbridge_scheduler_role_policy_name = "aws-prod-eventbridge-scheduler-policy"

###CPE Approved Security Groups####
sg_egress = {
  SG = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

###EIC_Endpoint###
EIC_vpc_ids = {
  vpc1 = {
  vpc_id     = "vpc-030cf9d82d0355521"
  subnet_ids = ["subnet-0017c75b14b341205"]
  project_tags = ["management-services","netapp-ontap-cloud","cloud-platform-engineering","vsa"]
  }
}

###EIC_SG_Attachment_Lambda_Function####
eic_sg_attachment_role_name = "aws-prod-eic-ssh-sg-attachment-role"
eic_sg_attachment_policy_name = "aws-prod-eic-ssh-sg-attachment-policy"
lambda_function_eic_sg_attachment_name = "aws-prod-eic-ssh-sg-attachment-function"
ec2_project_values = "[\"management-services\"]"

###Cost-Reports###
cost_report_bucket_name = "aws-prod-cost-report-s3-bucket"
lambda_cost_report_role_name = "aws-prod-cost-report-role"
lambda_cost_report_policy_name = "aws-prod-cost-report-policy"
lambda_function_cost_report_name = "aws-prod-cost-report-function"
cost_report_name = "aws-prod_cost_report_all-resources"
ACCESS_TEAM_LIST = "[\"ncats-devops\",\"ncats-developer\"]"
PROGRAM_PROJECT_MAP = <<EOF
{ "gard": ["gard"], "management-services": ["management-services"], "netapp": ["netapp", "data-archival"], "netapp-ontap-cloud": ["netapp-ontap-cloud"], "palantir": ["palantir", "nidap "], "polus": ["polus"], "rasldb": ["rasldb"], "itrb": ["itrb"], "servicenow": ["servicenow"] }
EOF

###CloudWatch alerts###
metric_namespace = "CloudWatchAlarms"
cloudtrail_loggroup_name = "CloudTrail/DefaultLogGroup"