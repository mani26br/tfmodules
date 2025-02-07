terraform {
  backend "s3" {
    bucket  = "aws-strides-scb-tfstate-s3"
    key     = "platform-services/terraform-aws-strides-scb.tfstate"
    region  = "us-east-1"
    access_key = "AWS_ACCESS_KEY"
    secret_key = "AWS_SECRET_ACCESS_KEY"
    role_arn = "arn:aws:iam::053895297011:role/aws-strides-scb-jenkins-pipeline-role"
    session_name = "terraform"
  }
}
