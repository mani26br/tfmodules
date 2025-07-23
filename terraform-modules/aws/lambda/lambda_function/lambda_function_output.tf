output "lambda_function_arn" {
  value = aws_lambda_function.lambda_function.arn
}

output "lambda_function_qualified_arn" {
  value = aws_lambda_function.lambda_function.qualified_arn
}

output "lambda_function_invoke_arn" {
  value = aws_lambda_function.lambda_function.invoke_arn
}

output "lambda_function_version" {
  value = aws_lambda_function.lambda_function.version
}

output "lambda_function_last_modified" {
  value = aws_lambda_function.lambda_function.last_modified
}

output "lambda_function_kms_key_arn" {
  value = aws_lambda_function.lambda_function.kms_key_arn
}

output "lambda_function_source_code_hash" {
  value = aws_lambda_function.lambda_function.source_code_hash
}

output "lambda_function_source_code_size" {
  value = aws_lambda_function.lambda_function.source_code_size
}