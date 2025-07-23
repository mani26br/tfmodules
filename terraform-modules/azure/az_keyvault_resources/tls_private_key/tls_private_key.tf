resource "tls_private_key" "tls_private" {
  algorithm   = var.algorithm
  rsa_bits    = var.rsa_bits 
}