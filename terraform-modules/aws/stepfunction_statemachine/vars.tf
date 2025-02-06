variable "state_machine_name" {
  type    = string
  default = ""
}


variable "state_machine_role" {
  type    = string
  default = ""
}


variable "state_machine_tags" {
  type    = map
  default = {}
}

# Relative Path of StateFunction Json File
variable "state_machine_definition_json_file" {
  type    = string
  default = ""
}
