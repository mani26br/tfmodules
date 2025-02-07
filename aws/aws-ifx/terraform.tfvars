platform_service_default_group_name = "853771734544-mfa-users"
IAM_role_arn = "arn:aws:iam::853771734544:role/aws-ifx-jenkins-pipeline-role"
common_tags = {     
      "project"       = "management-services"
      "environment"   = "ifx"
      "access-team"   = "ncats-devops"
}

###S3_tfstate_replication###
existing_tfstate_bucket_name = "aws-ifx-tfstate-s3"
s3_tfstate_bucket_prefix = "platform-services"
destination_tfstate_bucket_name = "aws-platform-services-tfstate-backup"
destination_account_number = "265129476828"

###CloudTrail###
aws_cloudtrail_sns_topic_name = "aws-ifx-cloudtrail-notifications"
aws_cloudtrail_sqs_name = "aws-ifx-cloudtrail-queue"
cloudtrail_s3_bucket = "aws-ifx-cloudtrail-s3-bucket"
cloudtrail_kms_alias_name = "alias/cloudtrail_kms_key"
cloudtrail_name = "aws-ifx-cloudtrail"
splunk_connection_role_name = "SplunkRoleAccess"


###Config###
aws_config_sns_topic_name = "aws-ifx-config-notifications"
config_s3_bucket_name = "aws-ifx-config-s3-bucket"
aws_config_sqs_name = "aws-ifx-config-queue"

##Guardduty###
guardduty_sns_topic_name = "aws-ifx-guardduty-notifications"
guardduty_sqs_name = "aws-ifx-guardduty-queue"
guardduty_logs_s3_bucket_name = "aws-ifx-guardduty-s3-bucket"
guardduty_event_name = "aws-ifx-guardduty-events"
guardduty_subscription_email = "NCATSCPE@mail.nih.gov"
guardduty_kms_alias_name = "alias/guardduty_kms_key"

###VPC_flow_logs###
flowlogrole_name = "aws-ifx-vpc-flow-log-role"
flowlogrole_policy_name = "aws-ifx-vpc-flow-log-policy"

###DNS_query_logs###
zone_id = ["Z1HLAJF5HYN5EL", "Z3B92TPOSXRTT8","Z8A10GFFVBPXA","Z05267332HPOAF9LI06QS","Z052718036OQF89M04V9E","Z01839182TVBWIXWBKZOS","Z0832865J5WECNQN960T","Z1EVQ36SN21AP9","Z044878528KFKS981YXYD","Z006404319SDZ1YASZQFV","ZD4MQKACZMW0R","Z2QCPEH4OLXLMQ"]

###AWS_System_Manager###
install_cw_agent_parameters = {
  action = "Install"
  name = "AmazonCloudWatchAgent"
}
aws_ssm_bucket_name = "aws-ifx-ssm-s3-bucket"

###AWS S3 Access Logs#####
aws_s3_accesslogs_destination_bucket = "aws-ifx-s3-accesslogs"
source_logging_bucket = ["aws-ifx-tfstate-s3","ncats-ct-logs"]
accesslogs_sqs_queue_name = "aws-ifx-s3-accesslogs-queue"

###Compliance_Report###
compliance_report_bucket_name = "aws-ifx-compliance-report-s3-bucket"
lambda_compliance_report_role_name = "aws-ifx-compliance-report-role"
lambda_compliance_report_policy_name = "aws-ifx-compliance-report-policy"
lambda_function_compliance_report_name = "aws-ifx-compliance-report-function"
compliance_report_name = "aws-ifx_required-tags_non-compliant_all-resources"
eventbridge_scheduler_role_name = "aws-ifx-eventbridge-scheduler-role"
eventbridge_scheduler_role_policy_name = "aws-ifx-eventbridge-scheduler-policy"

#####AWS_WAF_logs##########
existing_waf = "ifx-jenkins-lb-waf"
attached_albs = [
"arn:aws:elasticloadbalancing:us-east-1:853771734544:loadbalancer/app/ifx-jenkins-server-lb/3d13c7a02a1f8f8b",
"arn:aws:elasticloadbalancing:us-east-1:853771734544:loadbalancer/app/translator-jenkins-lb/3b212d09b0a73473"
]

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
  vpc_id     = "vpc-0653196d557f8578a"
  subnet_ids = ["subnet-0c02575a3936ffbb9"]
  project_tags = ["sctl", "rampdb", "informatics-core", "gsrs", "aicell", "sctl", "cure", "dpi", "pharos"]
  }
  vpc2 = {
  vpc_id     = "vpc-03a949e44486e0d35"
  subnet_ids = ["subnet-058bd3cdaa9ddaa2c"]
  project_tags = ["gsrs", "cure"]
  }
  vpc3 = {      
  vpc_id     = "vpc-0984642c5fb7cca4c"
  subnet_ids = ["subnet-0404e2ddb761e36b7"]
  project_tags = ["translator"]
  }
  vpc4 = {
  vpc_id     = "vpc-02327d1b994c0703a"
  subnet_ids = ["subnet-0342753c6361f1516"]
  project_tags = ["gsrs"]
  }
  # vpc5 = {
  # vpc_id     = "vpc-1e5a4f79"
  # subnet_ids = ["subnet-087e477d2de63dc5c"]
  # project_tags = ["informatics-core"]
  # }
  vpc6 = {
  vpc_id     = "vpc-0da1756ec5d1915c5"
  subnet_ids = ["subnet-0207cbc6c200c344b"]
  project_tags = ["translator"]
  }
  #vpc7 = {
  #vpc_id     = "vpc-0005a279068f14e5d"
  #subnet_ids = ["subnet-0ab5c81b529e7a0bd"]
  #project_tags = ["sctl","informatics-core","cure","ipsc","aicell"]
  #}
  #vpc8 = {
  #vpc_id     = "vpc-07cd1f1ac99b36f5b"
  #subnet_ids = ["subnet-0d512a87acb197273"]
  #project_tags = ["sctl"]
  #}
  vpc9 = {
  vpc_id     = "vpc-02fc20f3d97439d10"
  subnet_ids = ["subnet-0707292891ba0412d"]
  project_tags = ["translator"]
  }  
}

###EIC_SG_Attachment_Lambda_Function####

eic_sg_attachment_role_name = "aws-ifx-eic-ssh-sg-attachment-role"
eic_sg_attachment_policy_name = "aws-ifx-eic-ssh-sg-attachment-policy"
lambda_function_eic_sg_attachment_name = "aws-ifx-eic-ssh-sg-attachment-function"
ec2_project_values = "[\"rampdb\", \"cure\", \"gsrs\", \"aicell\", \"management-services\", \"dpi\", \"pharos\", \"sctl\", \"translator\", \"litcoin\", \"informatics-core\", \"ipsc\"]"

###Cost-Reports###

cost_report_bucket_name = "aws-ifx-cost-report-s3-bucket"
lambda_cost_report_role_name = "aws-ifx-cost-report-role"
lambda_cost_report_policy_name = "aws-ifx-cost-report-policy"
lambda_function_cost_report_name = "aws-ifx-cost-report-function"
cost_report_name = "aws-ifx_cost_report_all-resources"
ACCESS_TEAM_LIST = "[\"ncats-devops\",\"ncats-developer\"]"
PROGRAM_PROJECT_MAP = <<EOF
{ "aicell": ["aicell"], "cure": ["cure"], "drugs": ["drugs"], "gard": ["gard"], "gsrs": ["gsrs"], "activ": ["activ"], "informatics": ["informatics-core", "ordr", "stitcher"], "ipsc": ["ipsc"], "management-services": ["management-services"], "labshare": ["labshare"], "litcoin": ["litcoin"], "metaflow": ["metaflow"], "pharos": ["pharos"], "rampdb": ["rampdb"], "scb": ["scb"], "sctl": ["sctl"], "stemcell": ["stemcell"], "translator": ["translator"] }
EOF

###CloudWatch alerts###
metric_namespace = "CloudWatchAlarms"
cloudtrail_loggroup_name = "CloudTrail/DefaultLogGroup"