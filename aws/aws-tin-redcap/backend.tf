terraform {
  backend "s3" {
    bucket  = "aws-tin-redcap-tfstate-s3"
    key     = "platform-services/terraform-aws-tin-redcap.tfstate"
    region  = "us-east-1"
    access_key = "AWS_ACCESS_KEY"
    secret_key = "AWS_SECRET_ACCESS_KEY"
    role_arn = "arn:aws:iam::815639433089:role/aws-tin-redcap-jenkins-pipeline-role"
    session_name = "terraform"
  }
}
