terraform {
  backend "s3" {
    bucket  = "aws-prod-tfstate-s3"
    key     = "platform-services/terraform-aws-prod.tfstate"
    region  = "us-east-1"
    access_key = "AWS_ACCESS_KEY"
    secret_key = "AWS_SECRET_ACCESS_KEY"
    role_arn = "arn:aws:iam::183580792282:role/aws-prod-jenkins-pipeline-role"
    session_name = "terraform"
  }
}
