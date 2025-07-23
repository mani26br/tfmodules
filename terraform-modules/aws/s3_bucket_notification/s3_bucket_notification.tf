resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = var.bucket_notification_bucket

  dynamic "topic" {
    for_each = var.bucket_notification_topic

    content {
      id = lookup(topic.value, "id", null)
      topic_arn = lookup(topic.value, "topic_arn", null)
      events = lookup(topic.value, "events", null)
      filter_prefix = lookup(topic.value, "filter_prefix", null)
      filter_suffix = lookup(topic.value, "filter_suffix", null)
    }
  }

  dynamic "queue" {
    for_each = var.bucket_notification_queue

    content {
      id = lookup(queue.value, "id", null)
      queue_arn = lookup(queue.value, "queue_arn", null)
      events = lookup(queue.value, "events", null)
      filter_prefix = lookup(queue.value, "filter_prefix", null)
      filter_suffix = lookup(queue.value, "filter_suffix", null)
    }
  }

  dynamic "lambda_function" {
    for_each = var.bucket_notification_lambda_function

    content {
      id = lookup(lambda_function.value, "id", null)
      lambda_function_arn = lookup(lambda_function.value, "lambda_function_arn", null)
      events = lookup(lambda_function.value, "events", null)
      filter_prefix = lookup(lambda_function.value, "filter_prefix", null)
      filter_suffix = lookup(lambda_function.value, "filter_suffix", null)
    }
  }
}
