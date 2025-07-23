output "base_queue_url" {
  value = aws_sqs_queue.base_queue.id
}

output "deadletter_queue_url" {
  value = aws_sqs_queue.deadletter_queue.id
}

output "base_queue_arn" {
  value = aws_sqs_queue.base_queue.arn
}

