resource "aws_backup_selection" "backup_selection" {
  name = var.backup_selection_name
  plan_id = var.backup_selection_plan_id
  iam_role_arn = var.backup_selection_iam_role_arn

  dynamic "selection_tag" {
    for_each = var.backup_selection_tag

    content {
      type = "STRINGEQUALS"
      key = selection_tag.key
      value = selection_tag.value
    }
  }
  resources = var.backup_selection_resources
}
