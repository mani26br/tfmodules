resource "aws_iam_policy" "ec2_abac_policy" {
  name        =  var.ec2_policyname
  description = "IAM Policy for EC2 ABAC access"
  policy      = data.aws_iam_policy_document.ec2_abac_policy.json
}

