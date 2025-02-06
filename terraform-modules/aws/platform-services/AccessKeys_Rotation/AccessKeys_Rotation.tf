resource "aws_cloudwatch_event_rule" "key_rotation_trigger" {
  name        = var.key_rotation_trigger
  description = "Trigger IAM key rotation Lambda function"

    event_pattern = jsonencode({
    source      = ["aws.secretsmanager"],
    detail_type = ["AWS API Call via CloudTrail"],
    detail = {
      eventSource = ["secretsmanager.amazonaws.com"],
      eventName   = ["PutSecretValue"]
    }
  })
}

resource "aws_iam_role" "key_rotation_lambda_role" {
  name = "KeyRotationRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "key_rotation_lambda_basic_attachment" {
  role       = aws_iam_role.key_rotation_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "key_rotation_lambda_policy_attach_inline" {
  name        = "key_rotation_lambda_inline_policy"
  description = "Inline policy for key rotation Lambda function"
  policy = data.aws_iam_policy_document.inline_lambda_policy.json
}

resource "aws_cloudwatch_log_group" "key_rotation_lambda_log_group" {
  name = "/aws/lambda/${data.aws_caller_identity.current.id}/${var.environment}/AccessKeys/${aws_lambda_function.key_rotation_lambda.function_name}"
  retention_in_days = var.retention_period
}
resource "aws_iam_policy_attachment" "lambda_execution_policy_attachment" {
  name       = "lambda-execution-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  roles      = [aws_iam_role.key_rotation_lambda_role.name]
}

resource "aws_cloudwatch_event_target" "key_rotation_target" {
  rule      = aws_cloudwatch_event_rule.key_rotation_trigger.name
  target_id = "SendToSNS"
  arn       = "${aws_sns_topic.key_rotation_sns.arn}"
}

resource "aws_sns_topic" "key_rotation_sns" {
  name = var.sns_topic_name
}

resource "aws_sns_topic_policy" "key_rotation_sns_policy" {
  arn = "${aws_sns_topic.key_rotation_sns.arn}"
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.key_rotation_sns.arn
  protocol  = "email"
  endpoint  = var.email_subscription_endpoint
}

resource "aws_lambda_function" "key_rotation_lambda" {
  function_name = var.lambda_function_name
  role          = "${aws_iam_role.key_rotation_lambda_role.arn}"

  handler     = "key_rotation_handler.main"
  runtime     = "python3.7"
  timeout     = 30
  memory_size = 128
  environment {
    variables = {
      SECRET_NAME = "${var.secret_name}"
      REGION_NAME = "${var.region_name}"
    }
  }

  filename         = "${data.archive_file.key_rotation_lambda_zip.output_path}"
  source_code_hash = "${data.archive_file.key_rotation_lambda_zip.output_base64sha256}"    
}

 data "archive_file" "key_rotation_lambda_zip" {
  type        = "zip"
  source_file = "key_rotation_handler.py"
  output_path = "key_rotation_lambda.zip"
}
resource "null_resource" "invoke_lambda" {
   triggers = {

  }
  provisioner "local-exec" {
    command = "aws lambda invoke --function-name ${aws_lambda_function.key_rotation_lambda.function_name} /dev/null"
    
  }
}
