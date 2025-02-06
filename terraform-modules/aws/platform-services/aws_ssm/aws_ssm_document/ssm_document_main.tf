resource "aws_ssm_document" "document" {
  name          = var.document_name
  document_type = var.document_type

  content = var.document_content
  tags   = merge(tomap({
  "Name" = var.document_name,
  }), var.document_tags)
}