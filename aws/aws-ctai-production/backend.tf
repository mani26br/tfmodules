terraform {
  backend "s3" {
    bucket  = "aws-ctai-prod-tfstate-s3"
    key     = "platform-services/terraform-aws-ctai-prod.tfstate"
    region  = "us-east-1"
    access_key = "AWS_ACCESS_KEY"
    secret_key = "AWS_SECRET_ACCESS_KEY"
    role_arn = "arn:aws:iam::277271224396:role/aws-ctaiprod-jenkins-pipeline-role"
    session_name = "terraform"
  }
}
