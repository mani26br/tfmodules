resource "aws_transfer_ssh_key" "transfer_ssh_key" {
  server_id = var.transfer_ssh_key_server_id
  user_name = var.transfer_ssh_key_user_name
  body = var.transfer_ssh_key_body
}
