terraform {
  backend "s3" {
    bucket  = "aws-sharedservices-tfstate-s3"
    key     = "platform-services/terraform-aws-sharedservices.tfstate"
    region  = "us-east-1"
    access_key = "AWS_ACCESS_KEY"
    secret_key = "AWS_SECRET_ACCESS_KEY"
    role_arn = "arn:aws:iam::713419823391:role/aws-sharedservices-jenkins-pipeline-role"
    session_name = "terraform"
  }
}
