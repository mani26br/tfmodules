data "aws_caller_identity" "current" {}

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


data "aws_iam_policy_document" "sns_topic_policy" {
  version = "2012-10-17"

  statement {
    sid       = "AllowPublishFromCloudWatchEvents"
    effect    = "Allow"
    actions   = ["SNS:Publish"]
    resources = [aws_sns_topic.key_rotation_sns.arn]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}
