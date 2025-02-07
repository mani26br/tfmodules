platform_service_default_group_name = "063208468694-mfa-users"
IAM_role_arn = "arn:aws:iam::063208468694:role/aws-ci-jenkins-pipeline-role"
common_tags = {     
      "project"       = "management-services"
      "environment"   = "ci"
      "access-team"   = "ncats-devops"
      "technical-poc" = "cloud-platform-engineering"
}

###S3_tfstate_replication###
existing_tfstate_bucket_name = "aws-ci-tfstate-s3"
s3_tfstate_bucket_prefix = "platform-services"
destination_tfstate_bucket_name = "aws-platform-services-tfstate-backup"
destination_account_number = "265129476828"

###Config###
aws_config_sns_topic_name = "aws-ci-config-notifications"
config_s3_bucket_name = "aws-ci-config-s3-bucket"
aws_config_sqs_name = "aws-ci-config-queue"

##Guardduty###
guardduty_sns_topic_name = "aws-ci-guardduty-notifications"
guardduty_sqs_name = "aws-ci-guardduty-queue"
guardduty_logs_s3_bucket_name = "aws-ci-guardduty-s3-bucket"
guardduty_event_name = "aws-ci-guardduty-events"
guardduty_subscription_email = "NCATSCPE@mail.nih.gov"
guardduty_kms_alias_name = "alias/guardduty_kms_key"

###VPC_flow_logs###
flowlogrole_name = "aws-ci-vpc-flow-log-role"
flowlogrole_policy_name = "aws-ci-vpc-flow-log-policy"

###DNS_query_logs###
zone_id = ["Z38V3QYVHLCI7U"]

###AWS_System_Manager###
install_cw_agent_parameters = {
  action = "Install"
  name = "AmazonCloudWatchAgent"
}
aws_ssm_bucket_name = "aws-ci-ssm-s3-bucket"

###CloudWatch alerts###
metric_namespace = "CloudWatchAlarms"
cloudtrail_loggroup_name = "CloudTrail/DefaultLogGroup"

###AWS S3 Access Logs#####
aws_s3_accesslogs_destination_bucket = "aws-ci-s3-accesslogs"
source_logging_bucket = ["aws-ci-tfstate-s3","trail-ncats-ci"]
accesslogs_sqs_queue_name = "aws-ci-s3-accesslogs-queue"

#####AWS_WAF_logs##########
#existing_waf = "aws-ci-waf"
attached_albs = [
"arn:aws:elasticloadbalancing:us-east-1:063208468694:loadbalancer/app/passbolt-alb/96c1f84941e4023a",
"arn:aws:elasticloadbalancing:us-east-1:063208468694:loadbalancer/app/jenkins-alb/ce3761b912478951",
"arn:aws:elasticloadbalancing:us-east-1:063208468694:loadbalancer/app/rsc-ui-lb/53648ef3b1ccade1"
]
existing_waf = "gard-waf"
cloudfront_distribution_ids = ["d2hm3l4ti3ob5f","d6xzgh69k3m5o","d2fof2kogwqh8k"]

###Compliance_Report###
compliance_report_bucket_name = "aws-ci-compliance-report-s3-bucket"
lambda_compliance_report_role_name = "aws-ci-compliance-report-role"
lambda_compliance_report_policy_name = "aws-ci-compliance-report-policy"
lambda_function_compliance_report_name = "aws-ci-compliance-report-function"
compliance_report_name = "aws-ci_required-tags_non-compliant_all-resources"
eventbridge_scheduler_role_name = "aws-ci-eventbridge-scheduler-role"
eventbridge_scheduler_role_policy_name = "aws-ci-eventbridge-scheduler-policy"

###Compliance_Report_User###

compliance_report_assume_roles = [
  "arn:aws:iam::853771734544:role/compliance-report-assume-role",
  "arn:aws:iam::183580792282:role/compliance-report-assume-role",
  "arn:aws:iam::325527979383:role/compliance-report-assume-role",
  "arn:aws:iam::968896415489:role/compliance-report-assume-role",
  "arn:aws:iam::815639433089:role/compliance-report-assume-role",
  "arn:aws:iam::526622592716:role/compliance-report-assume-role",
  "arn:aws:iam::277271224396:role/compliance-report-assume-role",
  "arn:aws:iam::713419823391:role/compliance-report-assume-role",
  "arn:aws:iam::080246543900:role/compliance-report-assume-role",
  "arn:aws:iam::063869505732:role/compliance-report-assume-role",
  "arn:aws:iam::486494125541:role/compliance-report-assume-role",
  "arn:aws:iam::053895297011:role/compliance-report-assume-role"
]

/*
###aws_backup_plan###
aws_backup_rule_arn = "arn:aws:iam::063208468694:role/service-role/AWSBackupDefaultServiceRole"
aws_resource_assignment_name = "service_vault_backup"
aws_backup_plan_id = "0f4c3bd3-0fa5-47e6-bd31-a59474e8e576"
aws_assigned_resources = ["arn:aws:ec2:us-east-1:063208468694:instance/i-02068bf8413d13862"]
*/

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
  vpc_id     = "vpc-098b4739cdfffa7ca"
  subnet_ids = ["subnet-0e1b35524a11ed291"]
  project_tags = ["aws-githubrunner-2", "polus", "auth-ci", "gard", "auth", "aicp", "servicenow-mid", "snow", "coleylab", "aspire-aicp", "rsc", "agm", "project-tracking", "aicp-smartgraph", "askos", "cdd", "management-services", "asi", "aws-githubrunner-1"]
  }
  vpc2 = {
  vpc_id     = "vpc-06b733c338c244f05"
  subnet_ids = ["subnet-0b97963baf1b21b11"]
  project_tags = ["polus-omer-server"]
  }
  vpc3 = {      
  vpc_id     = "vpc-c7c005bd"
  subnet_ids = ["subnet-0286da4d2f912a0da"]
  project_tags = ["polus","polus-ben-hougton"]
  }
  vpc4 = {
  vpc_id     = "vpc-0cf7943770342c467"
  subnet_ids = ["subnet-0b25277a989ce69ec"]
  project_tags = ["management-services"]
  }
}

###EIC_SG_Attachment_Lambda_Function####

eic_sg_attachment_role_name = "aws-ci-eic-ssh-sg-attachment-role"
eic_sg_attachment_policy_name = "aws-ci-eic-ssh-sg-attachment-policy"
lambda_function_eic_sg_attachment_name = "aws-ci-eic-ssh-sg-attachment-function"
ec2_project_values = "[\"agm\", \"gard\", \"aicp\", \"management-services\", \"snow\", \"project-tracking\", \"smartgraph\", \"askos\", \"cdd\"]"

/*
###EIC_Endpoint###
EIC_vpc_ids = {
  vpc1 = {
  vpc_id     = "vpc-050d3a3d4e3de91ea"
  subnet_ids = ["subnet-0b940194344f5dc5d"]
  }
  vpc2 = {
  vpc_id     = "vpc-06b733c338c244f05"
  subnet_ids = ["subnet-0b97963baf1b21b11"]
  }
  vpc3 = {
  vpc_id     = "vpc-c7c005bd"
  subnet_ids = ["subnet-0286da4d2f912a0da"]
  }
  vpc4 = {
  vpc_id     = "vpc-0cf7943770342c467"
  subnet_ids = ["subnet-0b25277a989ce69ec"]
  }
  vpc5 = {
  vpc_id     = "vpc-098b4739cdfffa7ca"
  subnet_ids = ["subnet-0e1b35524a11ed291"]
  }
}
*/

###SNOW_Mid_Server###

mid_server_instance_ami = "ami-0c24dc9d92f3c28ea"
mid_server_subnet_id = "subnet-0e1b35524a11ed291"
mid_server_key = "snow-cur-ci-win"

###Cost-Reports###

snow_cur_report_bucket_name = "aws-ci-snow-cur-report-s3-bucket"
cost_report_bucket_name = "aws-ci-cost-report-s3-bucket"
lambda_cost_report_role_name = "aws-ci-cost-report-role"
lambda_cost_report_policy_name = "aws-ci-cost-report-policy"
lambda_function_cost_report_name = "aws-ci-cost-report-function"
cost_report_name = "aws-ci_cost_report_all-resources"
#PROJECT_LIST = "[\"polus\",\"polus-bastion-lin-ub\",\"polus-trainee-jesse\",\"aspire\",\"agm\"]"
#PROGRAM_LIST = "[\"aspire\", \"polus\", \"agm\"]"
ACCESS_TEAM_LIST = "[\"ncats-devops\",\"ncats-developer\"]"
PROGRAM_PROJECT_MAP = <<EOF
{ "polus": ["polus"], "agm": ["agm"], "aspire": ["aicp", "cdd", "askcos", "coleylab", "asi", "smartgraph"], "una": ["Una"], "gard": ["gard"], "activ": ["activ"], "metadata": ["metadata"], "usptorxn": ["usptorxn"], "thrizer": ["thrizer"], "catalog": ["catalog"], "gsrs": ["gsrs"], "management-services": ["management-services"], "cpe": ["cpe"], "publications": ["publications"], "globus": ["globus"], "itrb": ["itrb"], "icatalog": ["icatalog"], "n3c": ["n3c"], "ncats-splunk": ["ncats-splunk"], "snow": ["snow"], "covid19": ["covid19"], "project-tracking": ["project-tracking"], "nice-dcv.ci.aws.labshare.org": ["nice-dcv.ci.aws.labshare.org"], "q-business-datasource": ["q-business-datasource"], "umrs": ["umrs"], "rsc": ["rsc"], "smartcart": ["smartcart"], "m-21-31": ["m-21-31"], "pluriprot": ["pluriprot"] }
EOF

###AWS_Maintenance_Window_Start/Stop_EC2###

lambda_start_stop_role_name = "aws-ci-start-stop-lambda-role"
lambda_start_stop_policy_name = "aws-ci-start-stop-lambda-policy"
lambda_start_stop_notificaiton_name = "aws-ci-start-stop-sns-notification"
start_ssm_mw_payloads = {
  "AGM-start-notification" = <<EOF
{
  "ACTION": "start",
  "PROJECT": "agm",
  "SNS_TOPIC_ARN": ["arn:aws:sns:us-east-1:063208468694:aws-ci-itrb-notification"],
  "ACCOUNT": "aws-ci",
  "ENVIRONMENT": "dev"
}
EOF
  "ASPIRE-start-notification" = <<EOF
{
  "ACTION": "start",
  "PROJECT": "aspire",
  "SNS_TOPIC_ARN": ["arn:aws:sns:us-east-1:063208468694:aws-ci-itrb-notification"],
  "ACCOUNT": "aws-ci",
  "ENVIRONMENT": "dev"
}
EOF
  "GARD-start-notification" = <<EOF
{
  "ACTION": "start",
  "PROJECT": "gard",
  "SNS_TOPIC_ARN": ["arn:aws:sns:us-east-1:063208468694:aws-ci-itrb-notification"],
  "ACCOUNT": "aws-ci",
  "ENVIRONMENT": "dev"
}
EOF
  "PROJECT-TRACKING-start-notification" = <<EOF
{
  "ACTION": "start",
  "PROJECT": "project-tracking",
  "SNS_TOPIC_ARN": ["arn:aws:sns:us-east-1:063208468694:aws-ci-itrb-notification"],
  "ACCOUNT": "aws-ci",
  "ENVIRONMENT": "dev"
}
EOF
}

stop_ssm_mw_payloads = {
  "AGM-stop-notification" = <<EOF
{
  "ACTION": "stop",
  "PROJECT": "agm",
  "SNS_TOPIC_ARN": ["arn:aws:sns:us-east-1:063208468694:aws-ci-itrb-notification"],
  "ACCOUNT": "aws-ci",
  "ENVIRONMENT": "dev"
}
EOF
  "ASPIRE-stop-notification" = <<EOF
{
  "ACTION": "stop",
  "PROJECT": "aspire",
  "SNS_TOPIC_ARN": ["arn:aws:sns:us-east-1:063208468694:aws-ci-itrb-notification"],
  "ACCOUNT": "aws-ci",
  "ENVIRONMENT": "dev"
}
EOF
  "GARD-stop-notification" = <<EOF
{
  "ACTION": "stop",
  "PROJECT": "gard",
  "SNS_TOPIC_ARN": ["arn:aws:sns:us-east-1:063208468694:aws-ci-itrb-notification"],
  "ACCOUNT": "aws-ci",
  "ENVIRONMENT": "dev"
}
EOF
  "PROJECT-TRACKING-stop-notification" = <<EOF
{
  "ACTION": "stop",
  "PROJECT": "project-tracking",
  "SNS_TOPIC_ARN": ["arn:aws:sns:us-east-1:063208468694:aws-ci-itrb-notification"],
  "ACCOUNT": "aws-ci",
  "ENVIRONMENT": "dev"
}
EOF
}