data "aws_caller_identity" "current" {}

/*
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "inline_lambda_policy" {
   statement {
    actions   = ["lambda:InvokeFunction"]
    effect    = "Allow"
    resources = [aws_lambda_function.key_rotation_lambda.arn]
  }
}

data  "aws_iam_policy_document" "lambda_custom_policy_document" {
  statement {
    actions   = ["iam:ListUsers", "iam:CreateAccessKey", "iam:UpdateAccessKey", "iam:DeleteAccessKey"]
    resources = ["*"]
    effect    = "Allow"
  }
}
*/

