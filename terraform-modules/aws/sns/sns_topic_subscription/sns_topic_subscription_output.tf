output "sns_topic_subscription_id" {
  value = aws_sns_topic_subscription.sns_topic_subscription.id
}

output "sns_topic_subscription_topic_arn" {
  value = aws_sns_topic_subscription.sns_topic_subscription.topic_arn
}

output "sns_topic_subscription_protocol" {
  value = aws_sns_topic_subscription.sns_topic_subscription.protocol
}

output "sns_topic_subscription_endpoint" {
  value = aws_sns_topic_subscription.sns_topic_subscription.endpoint
}

output "sns_topic_subscription_arn" {
  value = aws_sns_topic_subscription.sns_topic_subscription.arn
}
