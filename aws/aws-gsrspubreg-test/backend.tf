terraform {
  backend "s3" {
    bucket  = "aws-gsrs-test-tfstate-s3"
    key     = "platform-services/terraform-aws-gsrs-test.tfstate"
    region  = "us-east-1"
    access_key = "AWS_ACCESS_KEY"
    secret_key = "AWS_SECRET_ACCESS_KEY"
    role_arn = "arn:aws:iam::063869505732:role/aws-gsrs-test-jenkins-pipeline-role"
    session_name = "terraform"
  }
}
