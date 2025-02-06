resource "aws_sns_topic_subscription" "sns_topic_subscription" {
  topic_arn = var.sns_topic_subscription_topic_arn
  protocol = var.sns_topic_subscription_protocol
  endpoint = var.sns_topic_subscription_endpoint
  endpoint_auto_confirms = var.sns_topic_subscription_endpoint_auto_confirms
  confirmation_timeout_in_minutes = var.sns_topic_subscription_confirmation_timeout_in_minutes
  raw_message_delivery = var.sns_topic_subscription_raw_message_delivery
  filter_policy = var.sns_topic_subscription_filter_policy
  delivery_policy = var.sns_topic_subscription_delivery_policy
}
