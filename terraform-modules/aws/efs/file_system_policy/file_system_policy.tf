resource "aws_efs_file_system_policy" "file_system_policy" {
  file_system_id = var.file_system_policy_file_system_id
  policy = var.file_system_policy
}
