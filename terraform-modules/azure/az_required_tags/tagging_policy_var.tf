variable "policy_name" {
  description = "The name of the policy definition."
  type        = string
} 

variable "subscription_id" {
  description = "The subscription ID for the Azure account."
  type        = list(string)
}

variable "policy_description" {
  description = "description of policy assignment"
  type        = string
  default = ""
}

variable "policy_assignment_name" {
  description = "The name of the policy assignment"
  type        = string
}

variable "resource_group_names" {
  description = "List of resource group names"
  type        = list(string)
}

variable "required_tags" {
  description = "List of tags to be enforced"
  type = list(string)
}

variable "non_compliance_message" {
  description = "message for non compliance"
  type = string
}