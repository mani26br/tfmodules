resource "aws_cloudwatch_event_rule" "instance_termination_rule" {
  name        = "InstanceTerminationRule"
  description = "Events rule for Instance termination notices"

  event_pattern = <<PATTERN
{
  "detail-type": [
    "EC2 Instance State-change Notification"
  ],  
  "source": [
    "aws.ec2"
  ]
}
PATTERN
}

resource "aws_cloudwatch_event_target" "instance_termination_rule_target_sns" {
  rule      = "${aws_cloudwatch_event_rule.instance_termination_rule.name}"
  target_id = "SendToSNS"
  arn       = "${aws_sns_topic.instance_termination_sns.arn}"
  input_transformer {
    input_paths = {
      instance-id  = "$.detail.instance-id"
      state = "$.detail.state"
      time = "$.time"
      region = "$.detail.region"
      account = "$.account"
    }
     input_template = <<-EOT
      "At <time>, the status of your EC2 instance <instance-id> on account <account> in the AWS Region <region> has changed to <state>."
    EOT
}
}

resource "aws_cloudwatch_event_target" "spot_instance_termination_rule_target_lambda" {
  rule      = "${aws_cloudwatch_event_rule.instance_termination_rule.name}"
  target_id = "InvokeLambda"
  arn       = "${aws_lambda_function.instance_termination_lambda.arn}"
}

resource "aws_cloudwatch_event_target" "spot_instance_termination_rule_target_sns" {
  rule      = "${aws_cloudwatch_event_rule.instance_termination_rule.name}"
  target_id = "SendToSNS"
  arn       = "${aws_sns_topic.instance_termination_sns.arn}"
}

resource "aws_cloudwatch_log_metric_filter" "instance_termination_metric_filter" {
  name           = "SpotInstanceTerminationMetricFilter"
  # pattern = "\"Deleting instance:\""
  pattern = "{$.message = \"Deleting instance:*\"}"
  log_group_name = aws_cloudwatch_log_group.instance_termination_lambda_log_group.name

  metric_transformation {
    name      = "InstanceTerminationMetric"
    namespace = "EC2/InstanceTermination"  # Replace with your desired namespace
    value     = "1"  # You can customize the value as needed
  }
}

resource "aws_cloudwatch_log_group" "instance_termination_lambda_log_group" {
  name = "/aws/lambda/${data.aws_caller_identity.current.id}/${var.environment}/decom_ec2/${aws_lambda_function.instance_termination_lambda.function_name}"
  retention_in_days = var.retention_period
}

resource "aws_iam_role" "instance_termination_lambda_role" {
  name = "instance_termination_lambda_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "instance_termination_lambda_basic_attachment" {
  role       = "${aws_iam_role.instance_termination_lambda_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy" "instance_termination_lambda_policy_attach_inline" {
  name   = "instance_termination_lambda_inline_policy"
  role   = aws_iam_role.instance_termination_lambda_role.name
  policy = data.aws_iam_policy_document.inline_lambda_policy.json
}


resource "aws_iam_policy" "lambda_ec2_termination_attachment" {
  name        = "LambdaTagCheckPolicy"
  description = "Policy for Lambda EC2 termination function"
  policy      = data.aws_iam_policy_document.lambda_ec2_termination_policy.json
}


resource "aws_iam_policy_attachment" "lambda_ec2_termination_attachment" {
  name       = "LambdaEC2TerminationAttachment"
  policy_arn = aws_iam_policy.lambda_ec2_termination_attachment.arn
  roles      = [aws_iam_role.instance_termination_lambda_role.name]
}


resource "aws_iam_policy" "s3_decommission_policy" {
  name        = "s3-decommission-policy"
  description = "IAM policy for S3 decommission"
  policy = data.aws_iam_policy_document.s3_decommission_policy.json
}

resource "aws_iam_policy_attachment" "s3_decommission_attachment" {
  name       = "S3DecommissionAttachment"
  policy_arn = aws_iam_policy.s3_decommission_policy.arn
  roles      = [aws_iam_role.instance_termination_lambda_role.name]
}


resource "aws_iam_role_policy_attachment" "lambda_vpc_decommission_policy_attachment" {
  role       = aws_iam_role.instance_termination_lambda_role.name
  policy_arn = aws_iam_policy.vpc_decommission_policy.arn
}

resource "aws_iam_policy" "vpc_decommission_policy" {
  name        = "VPCDecommissionPolicy"
  description = "Policy for VPC Decommission Lambda"
  
  policy = data.aws_iam_policy_document.vpc_decommission_policy.json
}


resource "aws_iam_role_policy_attachment" "lambda_elb_decommission_policy_attachment" {
  role       = aws_iam_role.instance_termination_lambda_role.name
  policy_arn = aws_iam_policy.elb_decommission_policy.arn
}

resource "aws_iam_policy" "elb_decommission_policy" {
  name        = "ELBDecommissionPolicy"
  description = "Policy for ELB Decommission Lambda"
  
  policy = data.aws_iam_policy_document.elb_decommission_policy.json
}


resource "aws_iam_role_policy_attachment" "lambda_elastic_ips_policy_attachment" {
  role       = aws_iam_role.instance_termination_lambda_role.name
  policy_arn = aws_iam_policy.elastic_ips_policy.arn
}

resource "aws_iam_policy" "elastic_ips_policy" {
  name        = "ElasticIPsPolicy"
  description = "Policy for Elastic IPs Lambda"
  
  policy = data.aws_iam_policy_document.elastic_ips_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_rds_decommission_policy_attachment" {
  role       = aws_iam_role.instance_termination_lambda_role.name
  policy_arn = aws_iam_policy.rds_decommission_policy.arn
}

resource "aws_iam_policy" "rds_decommission_policy" {
  name        = "RDSDecommissionPolicy"
  description = "Policy for RDS Lambda"
  
  policy = data.aws_iam_policy_document.rds_decommission_policy.json
}

resource "aws_lambda_function" "instance_termination_lambda" {
  function_name = var.lambda_function_name
  description   = "Handles Instance termination messages by gracefully shutting down the instance."
  role          = aws_iam_role.instance_termination_lambda_role.arn
  handler       = "instance_termination_handler.lambda_handler"
  runtime       = "python3.11"
  timeout       = 600
  memory_size   = 128
  publish       = true
 
  environment {
    variables = {
      KEY_VALUE     = var.key_value
      KEY           = var.key
    }
  }

  filename         = data.archive_file.instance_termination_lambda_zip.output_path
  source_code_hash = data.archive_file.instance_termination_lambda_zip.output_base64sha256

  # Configure Lambda to send logs to CloudWatch Logs
  tracing_config {
    mode = "PassThrough"
  }
}
resource "aws_iam_role_policy" "lambda_execution_policy" {
  name   = "LambdaExecutionPolicy"
  role   = aws_iam_role.instance_termination_lambda_role.name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"],
        Effect = "Allow",
        Resource = "*",
      },
    ],
  })
}


data "archive_file" "instance_termination_lambda_zip" {
  type        = "zip"
  output_path = "${path.module}/instance_termination_lambda.zip"
  source_dir = "${path.module}/instance_termination_lambda"
}

resource "aws_lambda_permission" "instance_termination_lambda_allow_cloudwatch" {
  statement_id  = "AllowInvokeFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.instance_termination_lambda.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_target.instance_termination_rule_target_sns.arn}"
}

resource "aws_sns_topic" "instance_termination_sns" {
  name = var.sns_topic_name
}

resource "aws_sns_topic_policy" "instance_termination_sns_policy" {
  arn    = aws_sns_topic.instance_termination_sns.arn
  #policy = data.aws_iam_policy_document.sns_topic_policy.json
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "snspolicy",
  "Statement": [{
    "Sid": "AllowPublishFromCloudWatchEvents",
    "Effect": "Allow",
    "Principal": {
      "Service": "events.amazonaws.com"
    },
    "Action": "sns:Publish",
    "Resource": "${aws_sns_topic.instance_termination_sns.arn}"
  }]
}
POLICY
depends_on = [aws_sns_topic.instance_termination_sns]
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.instance_termination_sns.arn
  protocol  = "email"
  endpoint  = var.email_subscription_endpoint
}

resource "aws_lambda_invocation" "invoke_lambda" {
  function_name = aws_lambda_function.instance_termination_lambda.function_name
  input         = jsonencode({
    KEY_VALUE = var.key_value
    KEY       = var.key
  })

  depends_on = [
    aws_cloudwatch_event_rule.instance_termination_rule,
    aws_cloudwatch_event_target.instance_termination_rule_target_sns,
    aws_lambda_permission.instance_termination_lambda_allow_cloudwatch,
  ]
}

# resource "null_resource" "invoke_lambda" {
#    triggers = {
#     # Add any triggers here that might affect the need to invoke the Lambda function
#   }

#   #depends_on = [aws_lambda_function.instance_termination_lambda]


#    provisioner "local-exec" {
#     command = "aws lambda invoke --function-name ${aws_lambda_function.instance_termination_lambda.function_name} --region ${var.aws_region} /dev/null"
#   }
# }


