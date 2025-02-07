terraform {
  backend "s3" {
    bucket  = "aws-scb-tfstate-s3"
    key     = "platform-services/us-east-2/terraform-aws-scb.tfstate"
    region  = "us-east-2"
    access_key = "AWS_ACCESS_KEY"
    secret_key = "AWS_SECRET_ACCESS_KEY"
    role_arn = "arn:aws:iam::080246543900:role/aws-scb-jenkins-pipeline-role"
    session_name = "terraform"
  }
}
