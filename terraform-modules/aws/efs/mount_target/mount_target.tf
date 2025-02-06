resource "aws_efs_mount_target" "mount_target" {
  file_system_id = var.mount_target_file_system_id
  subnet_id = var.mount_target_subnet_id
  ip_address = var.mount_target_ip_address
  security_groups = var.mount_target_security_groups
}
