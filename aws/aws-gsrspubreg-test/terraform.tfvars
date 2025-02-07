IAM_role_arn = "arn:aws:iam::063869505732:role/aws-gsrs-test-jenkins-pipeline-role"
#config_s3_bucket_name = "aws-config-gsrs-test-bucket"
common_tags = {     
      "project"       = "gsrs-test" 
      "environment"   = "test"
      "access-team"   = "ncats-devops"
}

###SNOW_Mid_Server###

mid_server_instance_ami = "ami-0c24dc9d92f3c28ea"
mid_server_subnet_id = "subnet-0f15286abe264d813"
mid_server_key = "midserver2019-gsrs-test"

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
  vpc_id     = "vpc-0d088cad4fe1f2d3f"
  subnet_ids = ["subnet-0f15286abe264d813"]
  project_tags = ["servicenow-mid"]
  }
}

###Compliance_Report###
compliance_report_bucket_name = "aws-gsrs-test-compliance-report-s3-bucket"
lambda_compliance_report_role_name = "aws-gsrs-test-compliance-report-role"
lambda_compliance_report_policy_name = "aws-gsrs-test-compliance-report-policy"
lambda_function_compliance_report_name = "aws-gsrs-test-compliance-report-function"
compliance_report_name = "aws-gsrs-test_required-tags_non-compliant_all-resources"
eventbridge_scheduler_role_name = "aws-gsrs-test-eventbridge-scheduler-role"
eventbridge_scheduler_role_policy_name = "aws-gsrs-test-eventbridge-scheduler-policy"