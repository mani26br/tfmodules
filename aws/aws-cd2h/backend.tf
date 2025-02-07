terraform {
  backend "s3" {
    bucket  = "aws-cd2h-tfstate-s3"
    key     = "platform-services/terraform-aws-cd2h.tfstate"
    region  = "us-east-1"
    access_key = "AWS_ACCESS_KEY"
    secret_key = "AWS_SECRET_ACCESS_KEY"
    role_arn = "arn:aws:iam::526622592716:role/aws-cd2h-jenkins-pipeline-role"
    session_name = "terraform"
  }
}
