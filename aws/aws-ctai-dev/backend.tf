terraform {
  backend "s3" {
    bucket  = "aws-ctai-dev-tfstate-s3"
    key     = "platform-services/terraform-aws-ctai-dev.tfstate"
    region  = "us-east-1"
    access_key = "AWS_ACCESS_KEY"
    secret_key = "AWS_SECRET_ACCESS_KEY"
    role_arn = "arn:aws:iam::229110399928:role/aws-ctaidev-jenkins-pipeline-role"
    session_name = "terraform"
  }
}
