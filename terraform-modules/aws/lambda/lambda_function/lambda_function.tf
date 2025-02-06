resource "aws_lambda_function" "lambda_function" {
  filename = var.lambda_function_filename
  s3_bucket = var.lambda_function_s3_bucket
  s3_key = var.lambda_function_s3_key
  s3_object_version = var.lambda_function_s3_object_version
  function_name = var.lambda_function_name

  dynamic "dead_letter_config" {
    for_each = var.lambda_function_dead_letter_config

    content {
      target_arn = lookup(dead_letter_config.value, "target_arn", null)
    }
  }

  handler = var.lambda_function_handler
  role = var.lambda_function_role
  description = var.lambda_function_description
  layers = var.lambda_function_layers
  memory_size = var.lambda_function_memory_size
  runtime = var.lambda_function_runtime
  timeout = var.lambda_function_timeout
  reserved_concurrent_executions = var.lambda_function_reserved_concurrent_executions
  publish = var.lambda_function_publish

  dynamic "vpc_config" {
    for_each = var.lambda_function_vpc_config

    content {
      subnet_ids = lookup(vpc_config.value, "subnet_ids", null)
      security_group_ids = lookup(vpc_config.value, "security_group_ids", null)
    }
  }

  # dynamic "environment" {
  #   for_each = var.lambda_function_environment

  #   content {
  #     variables = lookup(environment.value, "variables", null)
  #   }
  # }

  dynamic "environment" {
    for_each = var.environment == null ? [] : [var.environment]
    content {
      variables = environment.value.variables
    }
  }

  kms_key_arn = var.lambda_function_kms_key_arn
  source_code_hash = var.lambda_function_source_code_hash
  tags = merge(tomap({
  "Name" = var.lambda_function_name,
}), var.lambda_function_tags)
}