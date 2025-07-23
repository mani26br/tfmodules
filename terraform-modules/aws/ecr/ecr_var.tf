variable "ecr_repository_name" {
 type = string
 default = ""
}

variable "ecr_scan_images_on_push" {
 type = bool
 default = true
}

variable "ecr_image_tag_mutability" {
 type = string
 default = "MUTABLE"
}

variable "ecr_accounts" {
 type = list(string)
 default = []
}

variable "ecr_repository_tags" {
  type = map
  default = {}
}
