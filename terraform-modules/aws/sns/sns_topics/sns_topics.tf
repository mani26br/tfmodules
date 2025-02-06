resource "aws_sns_topic" "sns_topic" {
  name = var.sns_topic_name
  name_prefix = var.sns_topic_name_prefix
  display_name = var.sns_topic_display_name
  delivery_policy = var.sns_topic_delivery_policy
  application_success_feedback_role_arn = var.sns_topic_application_success_feedback_role_arn
  application_success_feedback_sample_rate = var.sns_topic_application_success_feedback_sample_rate
  application_failure_feedback_role_arn = var.sns_topic_application_failure_feedback_role_arn
  http_success_feedback_role_arn = var.sns_topic_http_success_feedback_role_arn
  http_success_feedback_sample_rate = var.sns_topic_http_success_feedback_sample_rate
  http_failure_feedback_role_arn = var.sns_topic_http_failure_feedback_role_arn
  kms_master_key_id = var.sns_topic_kms_master_key_id
  lambda_success_feedback_role_arn = var.sns_topic_lambda_success_feedback_role_arn
  lambda_success_feedback_sample_rate = var.sns_topic_lambda_success_feedback_sample_rate
  lambda_failure_feedback_role_arn = var.sns_topic_lambda_failure_feedback_role_arn
  sqs_success_feedback_role_arn = var.sns_topic_sqs_success_feedback_role_arn
  sqs_success_feedback_sample_rate = var.sns_topic_sqs_success_feedback_sample_rate
  sqs_failure_feedback_role_arn = var.sns_topic_sqs_failure_feedback_role_arn
  tags = merge(tomap({
  "Name"=var.sns_topic_name,
  }), var.sns_topic_tags)
}

resource "aws_sns_topic_policy" "sns_topic_policy" {
  arn = aws_sns_topic.sns_topic.arn
  policy = var.sns_topic_policy
}
