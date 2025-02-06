variable "access_point_file_system_id" {
  type    = string
  default = ""
}

variable "access_point_posix_user" {
  type    = any
  default = {}
}

variable "access_point_root_directory" {
  type    = any
  default = [{}]
}
