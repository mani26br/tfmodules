resource "aws_key_pair" "key" {
  key_name = var.key_name
  key_name_prefix = var.key_name_prefix
  public_key = var.key_public_key
  tags = merge(map(
    "key_name", var.key_name,
    ), var.key_tags)
}
