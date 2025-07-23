variable "iam_policy_name" {
  type    = string
  default = "NCATSMFAEnforcementPolicy"
}

variable "iam_policy_path" {
  type    = string
  default = "/"
}

variable "iam_policy_description" {
  type    = string
  default = "This policy is used to enforce the users/groups to use MFA"
}
