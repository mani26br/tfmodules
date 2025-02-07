IAM_role_arn = "arn:aws:iam::486494125541:role/aws-gsrs-prod-jenkins-pipeline-role"
#config_s3_bucket_name = "aws-config-ccos-bucket"
common_tags = {     
      "project"       = "gsrs-prod" 
      "environment"   = "prod"
      "access-team"   = "ncats-devops"
}

###SNOW_Mid_Server###

mid_server_instance_ami = "ami-0c24dc9d92f3c28ea"
mid_server_subnet_id = "subnet-07e96e6389420c6d6"
mid_server_key = "midserver2019-gsrs-prod"

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
  vpc_id     = "vpc-00bb669ac916c3591"
  subnet_ids = ["subnet-07e96e6389420c6d6"]
  project_tags = ["servicenow-mid"]
  }
}

###Compliance_Report###
compliance_report_bucket_name = "aws-gsrs-prod-compliance-report-s3-bucket"
lambda_compliance_report_role_name = "aws-gsrs-prod-compliance-report-role"
lambda_compliance_report_policy_name = "aws-gsrs-prod-compliance-report-policy"
lambda_function_compliance_report_name = "aws-gsrs-prod-compliance-report-function"
compliance_report_name = "aws-gsrs-prod_required-tags_non-compliant_all-resources"
eventbridge_scheduler_role_name = "aws-gsrs-prod-eventbridge-scheduler-role"
eventbridge_scheduler_role_policy_name = "aws-gsrs-prod-eventbridge-scheduler-policy"