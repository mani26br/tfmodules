terraform {
  backend "s3" {
    bucket  = ""
    key     = ""
    region  = "us-east-1"
    access_key = "AWS_ACCESS_KEY"
    secret_key = "AWS_SECRET_ACCESS_KEY"
    role_arn = ""
    session_name = "terraform"
  }
}
