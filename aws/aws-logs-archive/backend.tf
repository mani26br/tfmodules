terraform {
  backend "s3" {
    bucket  = "aws-logs-tfstate-s3"
    key     = "platform-services/terraform-aws-logs.tfstate"
    region  = "us-east-1"
    access_key = "AWS_ACCESS_KEY"
    secret_key = "AWS_SECRET_ACCESS_KEY"
    role_arn = "arn:aws:iam::265129476828:role/aws-logs-jenkins-pipeline-role"
    session_name = "terraform"
  }
}
