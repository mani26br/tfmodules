resource "aws_efs_file_system" "file_system" {
  creation_token = var.file_system_creation_token
  encrypted = var.file_system_encrypted
  kms_key_id = var.file_system_kms_key_id

  dynamic "lifecycle_policy" {
    for_each = var.file_system_lifecycle_policy
    content {
      transition_to_ia = lookup(lifecycle_policy.value, "transition_to_ia", null)
    }
  }

  performance_mode = var.file_system_performance_mode
  provisioned_throughput_in_mibps = var.file_system_provisioned_throughput_in_mibps
  tags = merge(map(
  "Name", var.file_system_name,
  ), var.file_system_tags)
  throughput_mode = var.file_system_throughput_mode
}
