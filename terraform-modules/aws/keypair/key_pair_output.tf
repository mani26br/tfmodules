output "key_name" {
  value = aws_key_pair.key.key_name
}

output "key_pair_id" {
  value = aws_key_pair.key.key_pair_id
}

output "fingerprint" {
  value = aws_key_pair.key.fingerprint
}
