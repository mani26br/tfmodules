resource "aws_lambda_invocation" "invocation" {
  function_name = var.lambda_function_name

  input = jsonencode({
    key1 = var.key_trigger
  })
}