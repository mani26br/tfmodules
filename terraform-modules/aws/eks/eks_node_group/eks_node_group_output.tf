output "eks_node_group_name" {
  value = aws_eks_node_group.eks_node_group.node_group_name
}

output "eks_node_subnet_ids" {
  value = aws_eks_node_group.eks_node_group.subnet_ids
}

output "eks_desired_size" {
  value = aws_eks_node_group.eks_node_group.scaling_config[0]
}

output "eks_node_release_version" {
  value = aws_eks_node_group.eks_node_group.release_version
}

output "eks_node_tags" {
  value = aws_eks_node_group.eks_node_group.tags
}

output "eks_node_resources" {
  value = aws_eks_node_group.eks_node_group.resources
}

output "eks_node_resources_asg" {
  value = aws_eks_node_group.eks_node_group.resources[0].autoscaling_groups
}

output "eks_node_resources_asg_name" {
  value = aws_eks_node_group.eks_node_group.resources[0].autoscaling_groups[0].name
}

output "eks_node_resources_sg_id" {
  value = aws_eks_node_group.eks_node_group.resources[0].remote_access_security_group_id
}
