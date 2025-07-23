data "archive_file" "origin_request_lambda_source" {
  type        = var.lambda_archive_type
  source_dir  = "${path.module}/${var.lambda_archive_source_dir}" # Path to the source code directory
  output_path = "${path.module}/${var.lambda_archive_output_path}"
}

output "output_path" {
  value = data.archive_file.origin_request_lambda_source.output_path
}

output "hash" {
  value = data.archive_file.origin_request_lambda_source.output_base64sha256
}