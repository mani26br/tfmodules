variable "eks_cluster_name" {
  description = "Provide the name of the cluster"
  type = string
  default = ""
}

variable "eks_node_group_name" {
  description = "Provide the name of the node group"
  type = string
  default = ""
}

variable "eks_node_role_arn" {
  description = "Provide the node role arn"
  type = string
  default = ""
}

variable "eks_node_subnet_ids" {
  description = "Provide the node subnet ids"
  type = list
  default = []
}

variable "eks_node_desired_size" {
  description = "Provide the node desired size"
  type = number
  default = null
}

variable "eks_node_max_size" {
  description = "Provide the node max size"
  type = number
  default = null
}

variable "eks_node_min_size" {
  description = "Provide the node minimum size"
  type = number
  default = null
}

variable "eks_node_disk_size" {
  description = "Please provide the required policy attachment"
  type = number
  default = null
}

variable "eks_launch_template_name" {
  description = "Please provide the eks launch template name"
  type = string
  default = null
}

variable "eks_launch_template_version" {
  description = "Please provide the eks launch template version"
  type = string
  default = null
}

variable "eks_node_release_version" {
  description = "Please provide the required policy attachment"
  type = string
  default = null
}

variable "eks_node_ec2_ssh_key" {
  description = "Please provide the ec2 ssh key id"
  type = string
  default = null
}

variable "eks_node_source_security_group_ids" {
  description = "Provide the node source security group ids"
  type = list
  default = []
}

variable "eks_node_role_policy_attachment" {
  description = "Provide the node role policy attachment"
  type = list
  default = []
}

variable "eks_node_tags" {
  description = "Provide the node tags"
  type = map
  default = {}
}

variable "eks_nodegrp_taint" {
  type = list(map(string))
  default = []
}

variable "eks_node_labels" {
   type = map
   default = {}
}
