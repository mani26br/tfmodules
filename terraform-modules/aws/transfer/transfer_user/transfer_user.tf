resource "aws_transfer_user" "transfer_user" {
  server_id = var.transfer_user_server_id
  user_name = var.transfer_user_user_name
  home_directory = var.transfer_user_home_directory
  policy = var.transfer_user_policy
  role = var.transfer_user_role
  tags = var.transfer_user_tags
}
