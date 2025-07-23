variable "name" {
  description = "The name of the SSM parameter store"
  type        = string
}

variable "description" {
  description = "A description for the SSM parameter store."
  type        = string
}

variable "type" {
  description = "The data type of the SSM parameter."
  type        = string
}

variable "value" {
  description = "The value to store in the SSM parameter."
  type        = string
}

variable "tags" {
  description = "The value to store in the SSM parameter."
  type = map(string)
  default = {}
}




