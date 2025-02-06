resource "aws_ssm_parameter" "parameter_stores" {
  name        = var.name
  description = var.description
  type        = var.type
  value       = var.value

  tags        = merge(tomap({
  "Name" = var.name,
  }), var.tags)
}

