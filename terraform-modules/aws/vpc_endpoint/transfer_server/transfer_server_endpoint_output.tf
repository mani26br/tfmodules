output "transfer_server_endpoint_id" {
  value = aws_vpc_endpoint.aws_transfer_server.id
}

output "transfer_server_endpoint_cidr_blocks" {
  value = aws_vpc_endpoint.aws_transfer_server.cidr_blocks
}

output "transfer_server_endpoint_dns_entry" {
  value = aws_vpc_endpoint.aws_transfer_server.dns_entry
}

output "transfer_server_endpoint_network_interface_ids" {
  value = aws_vpc_endpoint.aws_transfer_server.network_interface_ids
}

output "transfer_server_endpoint_owner_id" {
  value = aws_vpc_endpoint.aws_transfer_server.owner_id
}

output "transfer_server_endpoint_prefix_list_id" {
  value = aws_vpc_endpoint.aws_transfer_server.prefix_list_id
}

output "transfer_server_endpoint_requester_managed" {
  value = aws_vpc_endpoint.aws_transfer_server.requester_managed
}

output "transfer_server_endpoint_state" {
  value = aws_vpc_endpoint.aws_transfer_server.state
}
