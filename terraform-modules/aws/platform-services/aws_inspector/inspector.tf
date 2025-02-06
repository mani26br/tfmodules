resource "aws_inspector2_enabler" "inspector" {
  account_ids    = var.current_account_id
  resource_types = ["ECR", "EC2","LAMBDA"]
}
