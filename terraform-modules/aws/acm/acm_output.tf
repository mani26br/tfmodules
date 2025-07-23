output "cert_id" {
  value = aws_acm_certificate.cert.id
}

output "cert_arn" {
  value = aws_acm_certificate.cert.arn
}

output "cert_domain_name" {
  value = aws_acm_certificate.cert.domain_name
}

output "cert_domain_validation_options" {
  value = aws_acm_certificate.cert.domain_validation_options
}

output "cert_validation_emails" {
  value = aws_acm_certificate.cert.validation_emails
}
