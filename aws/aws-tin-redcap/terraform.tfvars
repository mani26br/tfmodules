platform_service_default_group_name = "815639433089-mfa-users"
IAM_role_arn = "arn:aws:iam::815639433089:role/aws-tin-redcap-jenkins-pipeline-role"
common_tags = {     
      "project"       = "ccos"
      "environment"   = "prod"
      "access-team"   = "ncats-devops"
}

/*
###Config###
aws_config_sns_topic_name = "aws-tin-redcap-config-notifications"
config_s3_bucket_name = "aws-config-aspe-bucket"
aws_config_sqs_name = "aws-tin-redcap-config-queue"

##Guardduty###
guardduty_sns_topic_name = "aws-tin-redcap-guardduty-notifications"
guardduty_sqs_name = "aws-tin-redcap-guardduty-queue"
guardduty_logs_s3_bucket_name = "aws-tin-redcap-guardduty-s3-bucket"
guardduty_event_name = "aws-tin-redcap-guardduty-events"
guardduty_subscription_email = "NCATSCPE@mail.nih.gov"
*/
###VPC_flow_logs###
flowlogrole_name = "aws-tin-redcap-vpc-flow-log-role"
flowlogrole_policy_name = "aws-tin-redcap-vpc-flow-log-policy"

###DNS_query_logs###
#zone_id = ["Z1034841NXJX3LSKB8MO", "Z04153112MD4V0ZJR1AAR"]

###SGC_AWS_Systems_Manager###
aws_ssm_sgc_bucket_name = "aws-tin-redcap-snow-sgc-data"
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
compliance_report_bucket_name = "aws-tin-redcap-compliance-report-s3-bucket"
lambda_compliance_report_role_name = "aws-tin-redcap-compliance-report-role"
lambda_compliance_report_policy_name = "aws-tin-redcap-compliance-report-policy"
lambda_function_compliance_report_name = "aws-tin-redcap-compliance-report-function"
compliance_report_name = "aws-tin-redcap_required-tags_non-compliant_all-resources"
eventbridge_scheduler_role_name = "aws-tin-redcap-eventbridge-scheduler-role"
eventbridge_scheduler_role_policy_name = "aws-tin-redcap-eventbridge-scheduler-policy"

###Cost-Reports###
cost_report_bucket_name = "aws-tin-redcap-cost-report-s3-bucket"
lambda_cost_report_role_name = "aws-tin-redcap-cost-report-role"
lambda_cost_report_policy_name = "aws-tin-redcap-cost-report-policy"
lambda_function_cost_report_name = "aws-tin-redcap-cost-report-function"
cost_report_name = "aws-tin-redcap_cost_report_all-resources"
ACCESS_TEAM_LIST = "[\"ncats-admins\",\"ncats-devops\",\"ncats-developer\"]"
PROGRAM_PROJECT_MAP = <<EOF
{ "ctsa/vumc":["tin-recap"] }
EOF
