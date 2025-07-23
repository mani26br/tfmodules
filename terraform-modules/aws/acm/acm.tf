resource "aws_acm_certificate" "cert" {
  #amazon issued cert
  domain_name = var.cert_domain_name
  #subject_alternative_names = var.cert_subject_alternative_names
  validation_method = var.cert_validation_method

  dynamic "options" {
    for_each = var.cert_options

    content {
      certificate_transparency_logging_preference = lookup(options.value, "certificate_transparency_logging_preference", null)
    }
  }

  #import existing cert
  private_key = var.cert_private_key
  certificate_body = var.cert_certificate_body
  certificate_chain = var.cert_certificate_chain
  certificate_authority_arn = var.cert_certificate_authority_arn
  tags = merge(map(
  "Name", var.cert_domain_name,
  ), var.cert_tags)
}
