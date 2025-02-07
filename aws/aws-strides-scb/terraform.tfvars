IAM_role_arn = "arn:aws:iam::053895297011:role/aws-strides-scb-jenkins-pipeline-role"
#config_s3_bucket_name = "aws-config-ccos-bucket"
common_tags = {     
      "project"       = "strides-scb" 
      "environment"   = "prod" 
      "access-team"   = "ncats-devops"
}

###SNOW_Mid_Server###

mid_server_instance_ami = "ami-0c24dc9d92f3c28ea"
mid_server_subnet_id = "subnet-016517573983b24ce"
mid_server_key = "midserver2019-strides-scb"

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
  vpc_id     = "vpc-0636324cd9fc3e7ab"
  subnet_ids = ["subnet-016517573983b24ce"]
  project_tags = ["servicenow-mid"]
  }
}

###Compliance_Report###
compliance_report_bucket_name = "aws-strides-scb-compliance-report-s3-bucket"
lambda_compliance_report_role_name = "aws-strides-scb-compliance-report-role"
lambda_compliance_report_policy_name = "aws-strides-scb-compliance-report-policy"
lambda_function_compliance_report_name = "aws-strides-scb-compliance-report-function"
compliance_report_name = "aws-strides-scb_required-tags_non-compliant_all-resources"
eventbridge_scheduler_role_name = "aws-strides-scb-eventbridge-scheduler-role"
eventbridge_scheduler_role_policy_name = "aws-strides-scb-eventbridge-scheduler-policy"