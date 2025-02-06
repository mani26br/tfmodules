output "file_system_id" {
  value = aws_efs_file_system.file_system.id
}

output "file_system_arn" {
  value = aws_efs_file_system.file_system.arn
}

output "file_system_dns_name" {
  value = aws_efs_file_system.file_system.dns_name
}
