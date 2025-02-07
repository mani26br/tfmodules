terraform {
  backend "s3" {
    bucket  = "aws-ci-tfstate-s3"
    key     = "platform-services/terraform-aws-ci.tfstate"
    region  = "us-east-1"
    access_key = "AWS_ACCESS_KEY"
    secret_key = "AWS_SECRET_ACCESS_KEY"
    role_arn = "arn:aws:iam::063208468694:role/aws-ci-jenkins-pipeline-role"
    session_name = "terraform"
  }
}
