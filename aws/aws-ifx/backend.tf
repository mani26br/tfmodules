terraform {
  backend "s3" {
    bucket  = "aws-ifx-tfstate-s3"
    key     = "platform-services/terraform-aws-ifx.tfstate"
    region  = "us-east-1"
    access_key = "AWS_ACCESS_KEY"
    secret_key = "AWS_SECRET_ACCESS_KEY"
    role_arn = "arn:aws:iam::853771734544:role/aws-ifx-jenkins-pipeline-role"
    session_name = "terraform"
  }
}

