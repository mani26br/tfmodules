###MFA###
module "iam-enforce-mfa-group-policy" {
  source = "../../terraform-modules/aws/platform-services/mfa_iam_policy/"
}

resource "aws_iam_group" "platform-service-default-group" {
  name = var.platform_service_default_group_name
}

resource "aws_iam_group_policy_attachment" "enforce-mfa-group-policy-attachment" {
  group      = aws_iam_group.platform-service-default-group.name
  policy_arn = module.iam-enforce-mfa-group-policy.iam_policy_arn
}
###configrules###
module "aws_configrecorder"{
  source = "../../terraform-modules/aws/platform-services/configrecorder/"
}

module "aws-NIST-800-53-configrules" {
  source = "../../terraform-modules/aws/platform-services/configrules/"
}

###passwd_policy###
module "passwd_policy"{
  source = "../../terraform-modules/aws/platform-services/passwd_policy/"
}
