module "aws_required_tags_rule"{
  source = "../../terraform-modules/aws/platform-services/configrules/required-tags-rule"
}

###SNOW_Mid_Server### 
module "EC2_SNOW_MID_Server" {
  source = "../../terraform-modules/aws/ec2"
  instance_name = "snow-strides-scb-win"
  instance_ami = var.mid_server_instance_ami #windows 2019 core base 
  instance_type = "t3.large"
  instance_subnet = var.mid_server_subnet_id
  instance_keyname = var.mid_server_key
  instance_vpc_sg_ids = [module.EC2_EIC_security_group_rdp["vpc1"].sg_id]
  instance_role = module.SNOW_MID_ec2_role.ec2_profile_name
  appinstance_tags = {     
    "project"       = "servicenow-mid" 
    "environment"   = "prod"
    "access-team"   = "ncats-devops"
    "techinical-poc" = "ncats-servicenow"
    "org" = "ncats"
    "program" = "ncats"
  }
}

###SNOW_Mid_Server_Instance_Profile### 

module "SNOW_MID_ec2_role" {
  source = "../../terraform-modules/aws/iam/iam_instance_profile"
  ec2_profile_name = "snow-strides-scb-win-role"
  iam_role_name = "snow-strides-scb-win-role"
  role_tags = var.common_tags
}

module "SNOW_MID_readonly_policy_attachment" {
  source = "../../terraform-modules/aws/iam/iam_role_policy_attachments"
  depends_on = [module.SNOW_MID_ec2_role]
  role_policy_attachment_role = module.SNOW_MID_ec2_role.ec2_profile_name
  role_policy_attachment_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

###CPE Approved Security Groups####

module "EC2_EIC_security_group_ssh" {
  source = "../../terraform-modules/aws/securitygroup"
  for_each = var.EIC_vpc_ids
  sg_name                  = "cpe-allowed-ec2-instance-ssh-sg"
  sg_description           = "Security groups on EC2 for EIC"
  sg_egress                = var.sg_egress
  assign_vpc_id            = each.value.vpc_id
  sg_tags                  = var.common_tags
}

module "EC2_EIC_security_group_rdp" {
  source = "../../terraform-modules/aws/securitygroup"
  for_each = var.EIC_vpc_ids
  sg_name                  = "cpe-allowed-ec2-instance-rdp-sg"
  sg_description           = "Security groups on EC2 for EIC"
  sg_egress                = var.sg_egress
  assign_vpc_id            = each.value.vpc_id
  sg_tags                  = var.common_tags
}

module "EIC_security_group" {
  source = "../../terraform-modules/aws/securitygroup"
  depends_on = [module.EC2_EIC_security_group_ssh, module.EC2_EIC_security_group_rdp]
  for_each = var.EIC_vpc_ids
  sg_name        = "cpe-allowed-ec2-connect-endpoint-sg"
  sg_description = "Security groups for EC2 instance connect"
  sg_egress = {
    SG = {
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      security_groups = [module.EC2_EIC_security_group_ssh[each.key].sg_id]
    }
    SG1 = {
      from_port       = 3389
      to_port         = 3389
      protocol        = "tcp"
      security_groups = [module.EC2_EIC_security_group_rdp[each.key].sg_id]
    }
  }
  assign_vpc_id = each.value.vpc_id
  sg_tags       = var.common_tags
}

module "EC2_EIC_security_group_ingress_rule_ssh" {
  source = "../../terraform-modules/aws/security_group_ingress_rule"
  depends_on = [module.EIC_security_group]
  for_each = var.EIC_vpc_ids
  sg_ingress_rule_id = module.EC2_EIC_security_group_ssh[each.key].sg_id
  referenced_sg_ingress_rule_id = module.EIC_security_group[each.key].sg_id
  sg_ingress_rule_from_port     = 22
  sg_ingress_rule_to_port       = 22 
}

module "EC2_EIC_security_group_ingress_rule_rdp" {
  source = "../../terraform-modules/aws/security_group_ingress_rule"
  depends_on = [module.EIC_security_group]
  for_each = var.EIC_vpc_ids
  sg_ingress_rule_id = module.EC2_EIC_security_group_rdp[each.key].sg_id
  referenced_sg_ingress_rule_id = module.EIC_security_group[each.key].sg_id
  sg_ingress_rule_from_port     = 3389
  sg_ingress_rule_to_port       = 3389 
}

###EIC_Endpoint###

module "EIC_assume_role" {
  source = "../../terraform-modules/aws/iam/iam_role"
  iam_role_name = "eic-assume-role"
  iam_role_assume_role_policy = data.aws_iam_policy_document.EIC_assume_role_policy.json
  iam_role_policy_name = "eic-policy"
  iam_role_policy = data.aws_iam_policy_document.EIC_role_policy.json
}

module "EC2_EIC" {
  source = "../../terraform-modules/aws/vpc_endpoint/ec2_instance_connect"
  depends_on = [module.EIC_security_group]
  for_each = var.EIC_vpc_ids
  ec2_instance_connect_name = "ec2-instance-connect-endpoint-${each.value.vpc_id}"
  ec2_instance_connect_subnet_id = each.value.subnet_ids[0]
  ec2_instance_connect_security_group_id = [module.EIC_security_group[each.key].sg_id]
  ec2_instance_connect_tags = var.common_tags
}

###Compliance_Report###

module "compliance_report_s3_bucket" {
  source = "../../terraform-modules/aws/platform-services/s3_bucket"
  bucket = var.compliance_report_bucket_name
  create_aws_s3_bucket_policy = false
  bucket_tags = var.common_tags
}

module "lambda_compliance_report_role" {
  source = "../../terraform-modules/aws/iam/iam_role"
  iam_role_name = var.lambda_compliance_report_role_name
  iam_role_assume_role_policy = data.aws_iam_policy_document.lambda_compliance_report_assume_role_policy.json
  iam_role_policy_name = var.lambda_compliance_report_policy_name
  iam_role_policy = data.aws_iam_policy_document.lambda_compliance_report_role_policy.json
}

module "eventbridge_scheduler_role" {
  source = "../../terraform-modules/aws/iam/iam_role"
  iam_role_name = var.eventbridge_scheduler_role_name
  iam_role_assume_role_policy = data.aws_iam_policy_document.eventbridge_scheduler_assume_role_policy.json
  iam_role_policy_name = var.eventbridge_scheduler_role_policy_name
  iam_role_policy = data.aws_iam_policy_document.eventbridge_scheduler_role_policy.json
}

module "lambda_archive_compliance_report" {
  source = "../../terraform-modules/aws/lambda/lambda_archive_file"
  lambda_archive_source_dir = "../../platform-services/lambda_scripts/compliance_report"
  lambda_archive_output_path = "../../platform-services/lambda_scripts/archive/compliance_report.zip"
}

module "lambda_function_compliance_report" {
  source = "../../terraform-modules/aws/lambda/lambda_function"
  lambda_function_name = var.lambda_function_compliance_report_name
  lambda_function_description = "Creates compliance report & sends to s3 bucket"
  lambda_function_role = module.lambda_compliance_report_role.iam_role_arn
  lambda_function_runtime = "python3.11"
  lambda_function_handler = "required_tags.send_noncompliant_required_tags_report_to_s3"
  lambda_function_filename = module.lambda_archive_compliance_report.output_path
  lambda_function_source_code_hash = module.lambda_archive_compliance_report.hash
  lambda_function_timeout = 600
  lambda_function_tags = var.common_tags
  environment = {
    variables = {
      s3_bucket = var.compliance_report_bucket_name
      report_name = var.compliance_report_name
      config_rule_name = "required-tags"
    }
  }
}

module "lambda_compliance_report_eventbridge_scheduler" {
  source = "../../terraform-modules/aws/platform-services/cloudwatch_event/eventbridge_scheduler"
  eventbridge_scheduler_name = "invoke-lambda-compliance-report-daily"
  eventbridge_scheduler_expression = "cron(0 4 * * ? *)"
  eventbridge_scheduler_timezone = "America/New_York"
  flexible_time_window_mode = "FLEXIBLE"
  flexible_maximum_window_in_minutes = 240
  eventbridge_scheduler_role_arn = module.eventbridge_scheduler_role.iam_role_arn
  eventbridge_scheduler_target_arn = module.lambda_function_compliance_report.lambda_function_arn
}

###Compliance_Report_Role###

module "compliance_report_role" {
  source = "../../terraform-modules/aws/iam/iam_role"
  iam_role_name = "compliance-report-assume-role"
  iam_role_assume_role_policy = data.aws_iam_policy_document.compliance_user_assumerole_trust_policy.json
  iam_role_policy_name = "compliance-report-role-policy"
  iam_role_policy = data.aws_iam_policy_document.compliance_user_role_policy_permissions.json
}