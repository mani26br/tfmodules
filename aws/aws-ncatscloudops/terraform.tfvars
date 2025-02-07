platform_service_default_group_name = "717192483375-mfa-users"
IAM_role_arn = "arn:aws:iam::717192483375:role/aws-ncatscloudops-jenkins-pipeline-role"
common_tags = {     
      "project"       = "ccos"
      "environment"   = "prod"
      "access-team"   = "ncats-devops"
}
project_tags = ["ccos", "cd2h", "tin-redcap", "ctai-production"]

/*
###Config###
aws_config_sns_topic_name = "aws-ncatscloudops-config-notifications"
config_s3_bucket_name = "aws-config-aspe-bucket"
aws_config_sqs_name = "aws-ncatscloudops-config-queue"

##Guardduty###
guardduty_sns_topic_name = "aws-ncatscloudops-guardduty-notifications"
guardduty_sqs_name = "aws-ncatscloudops-guardduty-queue"
guardduty_logs_s3_bucket_name = "aws-ncatscloudops-guardduty-s3-bucket"
guardduty_event_name = "aws-ncatscloudops-guardduty-events"
guardduty_subscription_email = "NCATSCPE@mail.nih.gov"
*/
###VPC_flow_logs###
flowlogrole_name = "aws-ncatscloudops-vpc-flow-log-role"
flowlogrole_policy_name = "aws-ncatscloudops-vpc-flow-log-policy"

###DNS_query_logs###
zone_id = ["Z01143361H7YPHOFF7ZQN"]

###SGC_AWS_Systems_Manager###
aws_ssm_sgc_bucket_name = "aws-ncatscloudops-snow-sgc-data"
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


####Resource_Decommission####
key = "decomm-state"
key_value = "to-be-decommissioned"
email_subscription_endpoint = "kiran.poloju@axleinfo.com"

###Compliance_Report###
compliance_report_bucket_name = "aws-ncatscloudops-compliance-report-s3-bucket"
lambda_compliance_report_role_name = "aws-ncatscloudops-compliance-report-role"
lambda_compliance_report_policy_name = "aws-ncatscloudops-compliance-report-policy"
lambda_function_compliance_report_name = "aws-ncatscloudops-compliance-report-function"
compliance_report_name = "aws-ncatscloudops_required-tags_non-compliant_all-resources"
eventbridge_scheduler_role_name = "aws-ncatscloudops-eventbridge-scheduler-role"
eventbridge_scheduler_role_policy_name = "aws-ncatscloudops-eventbridge-scheduler-policy"

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
  vpc = {
  vpc_id     = "vpc-0898167cb60d8a38f"
  subnet_ids = ["subnet-0f2d675d437fb4a97"]
  }
  vpc2 = {
  vpc_id     = "vpc-01c4e51c2519031e4"
  subnet_ids = ["subnet-07b58877ec15ad25a"]
  }
  vpc3 = {
  vpc_id     = "vpc-0633994c21f076e53"
  subnet_ids = ["subnet-012955228c894b3c5"]
  }
}

###ABAC policy#
ec2_policyname = "ABACManagedEC2UserAccess"

###Cost-Reports###
cost_report_bucket_name = "aws-cloud-ops-cost-reports-s3-bucket"
lambda_cost_report_role_name = "aws-cloud-ops-cost-report-role"
lambda_cost_report_policy_name = "aws-cloud-ops-cost-report-policy"
lambda_function_cost_report_name = "aws-cloud-ops-cost-report-function"
cost_report_name = "aws-cloud-ops_cost_report_all-resources"
ACCESS_TEAM_LIST = "[\"ncats-admins\",\"ncats-devops\",\"ncats-developer\"]"
PROGRAM_PROJECT_MAP = <<EOF
{ "ncats-cloud-ops":["sandbox"] }
EOF
