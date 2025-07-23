resource "aws_cloudwatch_log_group" "key_rotation_lambda_log_group" {
  name              = "/aws/lambda/${data.aws_caller_identity.current.account_id}/${var.environment}/AccessKeys/${aws_lambda_function.key_rotation_lambda.function_name}"
  retention_in_days = var.retention_period
}

resource "aws_lambda_function" "key_rotation_lambda" {
  function_name    = var.lambda_function_name
  role             = var.existing_role_arn
  handler          = "key_rotation_handler.lambda_handler"
  runtime          = "python3.8"
  timeout          = 600
  memory_size      = 128
  source_code_hash = data.archive_file.key_rotation_lambda_zip.output_base64sha256
  filename         = data.archive_file.key_rotation_lambda_zip.output_path

  environment {
    variables = {
      VAULT_URL       = var.vault_url
      APPROLE_NAME    = var.approle_name
      VAULT_ROLE_ID   = var.vault_role_id
      VAULT_SECRET_ID = var.vault_secret_id
      
    }
  }
}

data "archive_file" "key_rotation_lambda_zip" {
  type        = "zip"
  output_path = "${path.module}/key_rotation_lambda.zip"
  
  source {
    content  = file("${path.module}/key_rotation_handler.py")
    filename = "key_rotation_handler.py"
  }

  source {
    content  = "${path.module}/requests/*"
    filename = "requests/*"
  }

  source {
    content  = "${path.module}/charset_normalizer/*"
    filename = "charset_normalizer/*"
  }

  source {
    content  = "${path.module}/urllib3/*"
    filename = "urllib3/*"
  }

  source {
    content  = "${path.module}/idna/*"
    filename = "idna/*"
  }

  source {
    content  = "${path.module}/certifi/*"
    filename = "certifi/*"
  }
}
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
resource "aws_lambda_permission" "key_rotation_lambda_allow_cloudwatch" {
  statement_id  = "AllowInvokeFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.key_rotation_lambda.function_name
  principal     = "events.amazonaws.com"
}

resource "aws_lambda_invocation" "invoke_lambda" {
  function_name = aws_lambda_function.key_rotation_lambda.function_name
  input       = jsonencode({
    VAULT_URL       = var.vault_url,
    VAULT_ROLE_ID   = var.vault_role_id,
    VAULT_ROLE_ID   = var.vault_role_id
    VAULT_SECRET_ID = var.vault_secret_id,
    USER_NAME   =  var.user_name
    SECRET_PATH =  var.secret_path
    
  })

  depends_on = [
    aws_cloudwatch_event_rule.key_rotation_trigger,
    aws_lambda_permission.key_rotation_lambda_allow_cloudwatch,
  ]
}
