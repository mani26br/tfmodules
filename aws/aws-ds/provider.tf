# Terraform version 1.2.3
terraform {
  required_version = "=1.2.4"
}

provider "aws" {
  version = "~> 4.0"
  region  = var.AWS_REGION
  profile = "aws-ds-deploy"
}
