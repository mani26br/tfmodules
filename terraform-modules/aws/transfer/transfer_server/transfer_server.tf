resource "aws_transfer_server" "transfer_server" {
  dynamic "endpoint_details" {
    for_each = var.transfer_server_endpoint_details
    content {
      vpc_endpoint_id = lookup(endpoint_details.value, "vpc_endpoint_id", null)
    }
  }
  endpoint_type = var.transfer_server_endpoint_type
  invocation_role = var.transfer_server_invocation_role
  host_key = var.transfer_server_host_key
  url = var.transfer_server_url
  identity_provider_type = var.transfer_server_identity_provider_type
  logging_role = var.transfer_server_logging_role
  force_destroy = var.transfer_server_force_destroy
  tags = merge(map(
  "endpoint_type", var.transfer_server_endpoint_type,
  ), var.transfer_server_tags)
}
