resource "aws_efs_access_point" "access_point" {
  file_system_id = var.access_point_file_system_id

  dynamic "posix_user" {
    for_each = var.access_point_posix_user

    content {
      gid = lookup(posix_user.value, "gid", null)
      uid = lookup(posix_user.value, "uid", null)
      secondary_gids = lookup(posix_user.value, "secondary_gids", null)
    }
  }

  dynamic "root_directory" {
    for_each = var.access_point_root_directory

    content {
      path = lookup(root_directory.value, "path", null)

      dynamic "creation_info" {
        for_each = lookup(root_directory.value, "creation_info", {})

        content {
          owner_gid = lookup(creation_info.value, "owner_gid", null)
          owner_uid = lookup(creation_info.value, "owner_uid", null)
          permissions = lookup(creation_info.value, "permissions", null)
        }

      }
    }

  }
}
