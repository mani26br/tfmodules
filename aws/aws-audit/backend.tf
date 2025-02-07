terraform {
  backend "s3" {
    bucket  = "aws-audit-tfstate-s3"
    key     = "platform-services/terraform-aws-audit.tfstate"
    region  = "us-east-1"
    access_key = "AWS_ACCESS_KEY"
    secret_key = "AWS_SECRET_ACCESS_KEY"
    role_arn = "arn:aws:iam::454343540246:role/aws-audit-jenkins-pipeline-role"
    session_name = "terraform"
  }
}
