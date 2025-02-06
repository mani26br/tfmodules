output "tls-private-key-id" {
  description = "tls private key ID"
  value       = tls_private_key.tls_private.id
}

output "private_key_pem" {
  description = "The private key data in PEM format."
  value       = tls_private_key.tls_private.private_key_pem
}

output "public_key_openssh" {
  description = "The public key data in OpenSSH"
  value       = tls_private_key.tls_private.public_key_openssh
}
