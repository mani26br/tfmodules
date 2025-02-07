# Terraform version 1.2.3
terraform {
  required_version = "=1.2.4"
}

provider "aws" {
  version = "~> 5.0"
  region  = "us-east-1"
  access_key = "AWS_ACCESS_KEY"
  secret_key = "AWS_SECRET_ACCESS_KEY"
  assume_role {
    role_arn    = var.IAM_role_arn
  }
  default_tags {
     tags = {
       "org"           = "ncats"
       "program"       = "ctsa/clic"
       "technical-poc" = "cloud-platform-engineering"
     }
  }
} 
 
provider "aws" {
  version = "~> 5.0"
  region  = "us-east-2"
  access_key = "AWS_ACCESS_KEY"
  secret_key = "AWS_SECRET_ACCESS_KEY"
  alias = "us-east-2"
  assume_role {
    role_arn    = var.IAM_role_arn
  }
}
