terraform {
  backend "s3" {
    bucket  = "aws-ncatscloudops-tfstate-s3"
    key     = "platform-services/terraform-aws-ncatscloudops.tfstate"
    region  = "us-east-1"
    access_key = "AWS_ACCESS_KEY"
    secret_key = "AWS_SECRET_ACCESS_KEY"
    role_arn = "arn:aws:iam::717192483375:role/aws-ncatscloudops-jenkins-pipeline-role"
    session_name = "terraform"
  }
}
