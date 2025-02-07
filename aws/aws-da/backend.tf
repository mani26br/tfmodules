terraform {
  backend "s3" {
    bucket  = "aws-da-tfstate-s3"
    key     = "platform-services/terraform-aws-da.tfstate"
    region  = "us-east-1"
    access_key = "AWS_ACCESS_KEY"
    secret_key = "AWS_SECRET_ACCESS_KEY"
    role_arn = "arn:aws:iam::082241233635:role/aws-da-jenkins-pipeline-role"
    session_name = "terraform"
  }
}
