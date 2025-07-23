variable "fileshare_name" {
  type = string
  default = ""
}

variable "storage_account_name" {
  type = string
  default = ""
}

variable "quota_id" {
  type = string
  default = ""
}

variable "fileshare_aclid" {
  type = string
  default = ""
}

variable "aclid" {
  type = any
  default = {}
}

variable "access_policy" {
  type = any
  default = {}
}


variable "permissions" {
  type = string
  default = ""
}

variable "startdate" {
  type = string
  default = ""
}

variable "expirydate" {
  type = string
  default = ""
}
