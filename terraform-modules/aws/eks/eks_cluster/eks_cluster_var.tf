variable "eks_cluster_name" {
  description = "EKS cluster name"
  type = string
  default = null
}

variable "eks_subnet_ids" {
  description = "Please provide the subnet ids where to create the kubernetes cluster"
  type = list
  default = []
}

variable "eks_version" {
  description = "Please provide the kubernetes version"
  type = string
  default = null
}

variable "eks_roles_arn" {
  description = "Please provide the arn for iam"
  type = string
  default = null
}

variable "eks_role_policy_attachment" {
  description = "Please provide the required policy attachment"
  type = list
  default = []
}

variable "eks_additional_security_group_ids" {
   description = "Optional additional cluster security group id"
   type = list
   default = []
}

variable "eks_enabled_cluster_log_types" {
   description = "Enabling Control Plane Logging"
   type = list
   default = []
}

variable "eks_cluster_tags" {
  description = "Provide the cluster tags"
  type = map
  default = {}
}

variable "eks_endpoint_public_access" {
  description = "To Allow/Deny public access on endpoint"
  type = bool
  default = false
}

variable "eks_public_access_cidrs" {
  description = "Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled."
  type = list
  default = ["0.0.0.0/0"]
}