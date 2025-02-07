terraform {
  backend "s3" {
    bucket  = "ls-terraform-states"
    key     = "platform-services/terraform-aws-test.tfstate"
    region  = "us-east-1"
    profile = "aws-ds-s3"
  }
}
