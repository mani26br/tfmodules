terraform {
  backend "s3" {
    bucket  = "aws-aspe-prod-tfstate-s3"
    key     = "platform-services/terraform-aws-aspe-prod.tfstate"
    region  = "us-east-1"
    access_key = "AWS_ACCESS_KEY"
    secret_key = "AWS_SECRET_ACCESS_KEY"
    role_arn = "arn:aws:iam::325527979383:role/aws-aspe-prod-jenkins-pipeline-role"
    session_name = "terraform"
  }
}
