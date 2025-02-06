variable "vpccidr" {
  type = string
  default = ""
}

variable "vpctenancy" {
  type = string
  default = "default"
}

variable "dnssupport" {
  type = bool
  default = "true"
}

variable "dnshostname" {
  type = bool
  default = "true"
}

variable "vpcclassiclink" {
  type = bool
  default = "false"
}

variable "vpcclassiclink_dns" {
  type = bool
  default = "false"
}

variable "vpccidrblockipv6" {
  type = bool
  default = "false"
}

variable "vpcname" {
  type = string
  default = ""
}

variable "vpc_tags" {
  type = map
  default = {}
}
