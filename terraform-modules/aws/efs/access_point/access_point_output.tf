output "access_point_id" {
  value = aws_efs_access_point.access_point.id
}

output "access_point_arn" {
  value = aws_efs_access_point.access_point.arn
}

output "access_point_file_system_arn" {
  value = aws_efs_access_point.access_point.file_system_arn
}
