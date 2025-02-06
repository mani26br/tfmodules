resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_cluster_name
  role_arn = var.eks_roles_arn
  vpc_config {
    subnet_ids = var.eks_subnet_ids
    security_group_ids = var.eks_additional_security_group_ids
    endpoint_public_access  = var.eks_endpoint_public_access
    public_access_cidrs = var.eks_public_access_cidrs
  }
  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [var.eks_role_policy_attachment]
  version = var.eks_version

  enabled_cluster_log_types = var.eks_enabled_cluster_log_types
  tags = merge(tomap({
  "Name" = var.eks_cluster_name,
}), var.eks_cluster_tags)
}
