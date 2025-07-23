//AZ-Policy Variables
variable "source" {
  description = "source of the policy"
  type = string
  default = null
}

variable "version" {
  description = "policy version"
  type = string
  default = null
}

variable "client_name" {
  description = "Client name/account used in naming"
  type = string
  default = null
}

variable "environment" {
  description = "project enviroment"
  type = string
  default = null
}

variable "location" {
  description = "location"
  type = string
  default = null
}

variable "location_short" {
  description = "location_short"
  type = string
  default = null
}

variable "stack" {
  description = "Client name/account used in naming"
  type = string
  default = null
}

variable "tags" {
  description = "tags"
  type = string
  default = null
}

variable "policy_tags_rule" {
  description = "policy_tags_rule"
  type = string
  default = null
}

variable "policy_tags_parameters" {
  description = "policy_tags_parameters"
  type = string
  default = null
}

variable "policy_mode" {
  description = "policy_mode"
  type = string
  default = null
}

variable "policy_assignment_display_name" {
  description = "policy_assignment_display_name"
  type = string
  default = null
}

variable "policy_assignments" {
  description = "policy_assignments"
  type = map
  default = {}
}


// Az Policy Assignment Variables

variable "name" {
  description = "(Required) The name of the Policy Assignment. Changing this forces a new resource to be created."
  type = string
  default = null
}
variable "scope" {
  description = "(Required) The Scope at which the Policy Assignment should be applied, which must be a Resource ID"
  type = string
  default = null
}
variable "policy_definition_id" {
  description = "(Required) The ID of the Policy Definition to be applied at the specified Scope."
  type = string
  default = null
}
variable "description" {
  description = "(Optional) A description to use for this Policy Assignment. Changing this forces a new resource to be created."
  type = string
  default = null
}
variable "display_name" {
  description = "(Optional) A friendly display name to use for this Policy Assignment. Changing this forces a new resource to be created."
  type = string
  default = null
}
variable "metadata" {
  description = "(Optional) The metadata for the policy assignment. This is a JSON string representing additional metadata that should be stored with the policy assignment."
  type = string
  default = null
}

variable "parameters" {
  description = "(Optional) Parameters for the policy definition. This field is a JSON string that maps to the Parameters field from the Policy Definition. Changing this forces a new resource to be created."
  type = string
  default = null
}
