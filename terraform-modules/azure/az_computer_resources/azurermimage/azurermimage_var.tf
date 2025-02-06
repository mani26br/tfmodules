variable "virtual_image-name" {
  description = "Please provide virtual image's name (Required)"
  type = string
  default = ""
}

variable "virtual_image-resource_group_name" {
  description = "Please provide virtual image's Resource Group name (Required)"
  type = string
  default = ""
}

variable "virtual_image-location" {
  description = "Please provide virtual image's location (Required)"
  type = string
  default = ""
}

variable "virtual_image-os_disk" {
  description = "Please provide virtual image's OS disk options"
  type = list(map(string))
  default = []
}
