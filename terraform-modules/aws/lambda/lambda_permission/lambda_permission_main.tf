resource "aws_lambda_permission" "lambda_permission_invoke" {
  statement_id  = var.lambda_permission_statement_id 
  action        = var.lambda_permission_action 
  function_name = var.lambda_permission_function_name 
  principal     = var.lambda_permission_principal 
  source_arn    = var.lambda_permission_source_arn 
}