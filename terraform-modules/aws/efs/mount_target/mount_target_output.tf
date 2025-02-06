output "mount_target_id" {
  value = aws_efs_mount_target.mount_target.id
}

output "mount_target_dns_name" {
  value = aws_efs_mount_target.mount_target.dns_name
}

output "mount_target_mount_target_dns_name" {
  value = aws_efs_mount_target.mount_target.mount_target_dns_name
}

output "file_system_arn" {
  value = aws_efs_mount_target.mount_target.file_system_arn
}

output "network_interface_id" {
  value = aws_efs_mount_target.mount_target.network_interface_id
}

output "availability_zone_name" {
  value = aws_efs_mount_target.mount_target.availability_zone_name
}

output "availability_zone_id" {
  value = aws_efs_mount_target.mount_target.availability_zone_id
}

output "owner_id" {
  value = aws_efs_mount_target.mount_target.owner_id
}
