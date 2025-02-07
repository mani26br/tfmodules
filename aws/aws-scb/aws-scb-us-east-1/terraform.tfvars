platform_service_default_group_name = "080246543900-mfa-users"
IAM_role_arn = "arn:aws:iam::080246543900:role/aws-scb-jenkins-pipeline-role"
common_tags = {     
      "project"       = "itrb"
      "environment"   = "prod"
      "access-team"   = "ncats-devops"
}

###CloudTrail###
aws_cloudtrail_sns_topic_name = "aws-scb-cloudtrail-notifications"
aws_cloudtrail_sqs_name = "aws-scb-cloudtrail-queue"
cloudtrail_s3_bucket = "aws-scb-cloudtrail-s3-bucket"
cloudtrail_kms_alias_name = "alias/cloudtrail_kms_key"
cloudtrail_name = "aws-scb-cloudtrail"
splunk_connection_role_name = "SplunkRoleAccess"

###Config###
aws_config_sns_topic_name = "aws-scb-config-notifications-us-east-1"
config_s3_bucket_name = "aws-scb-config-s3-bucket-us-east-1"
aws_config_sqs_name = "aws-scb-config-queue-us-east-1"


##Guardduty###
guardduty_sns_topic_name = "aws-scb-gurardduty-notifications-us-east-1"
guardduty_sqs_name = "aws-scb-guardduty-queue-us-east-1"
guardduty_logs_s3_bucket_name = "aws-scb-gurdduty-s3-bucket-us-east-1"
guardduty_event_name = "aws-scb-guardduty-events-us-east-1"
guardduty_subscription_email = "NCATSCPE@mail.nih.gov"
guardduty_kms_alias_name = "alias/guardduty_kms_key_us-east-1"

###VPC_flow_logs###
flowlogrole_name = "aws-scb-vpc-flow-log-role-us-east-1"
flowlogrole_policy_name = "aws-scb-vpc-flow-log-policy-us-east-1"

###DNS_query_logs###
zone_id = ["Z0225153129GPS4CBZ72V", "Z0069976184B3J6IKCXAF", "Z0421224XZW6JV10NLE8"]

###SGC_AWS_Systems_Manager###
aws_ssm_sgc_bucket_name = "aws-scb-snow-sgc-data-us-east-1"
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


###Compliance_Report###
compliance_report_bucket_name = "aws-scb-compliance-report-s3-bucket-us-east-1"
compliance_report_bucket_name_us_east_2 = "aws-scb-compliance-report-s3-bucket-us-east-2"
lambda_compliance_report_role_name = "aws-scb-compliance-report-role"
lambda_compliance_report_policy_name = "aws-scb-compliance-report-policy"
lambda_function_compliance_report_name = "aws-scb-compliance-report-function-us-east-1"
compliance_report_name = "aws-scb_required-tags_non-compliant_all-resources-us-east-1"
eventbridge_scheduler_role_name = "aws-scb-eventbridge-scheduler-role"
eventbridge_scheduler_role_policy_name = "aws-scb-eventbridge-scheduler-policy"
compliance_report_lambda_function_us_east_2 = "arn:aws:lambda:us-east-2:080246543900:function:aws-scb-compliance-report-function-us-east-2"

###CPE Approved Security Groups####

sg_egress = {
  SG = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}