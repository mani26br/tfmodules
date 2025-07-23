resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = var.eks_cluster_name
  node_group_name = var.eks_node_group_name
  node_role_arn   = var.eks_node_role_arn
  subnet_ids      = var.eks_node_subnet_ids

  scaling_config {
    desired_size = var.eks_node_desired_size
    max_size     = var.eks_node_max_size
    min_size     = var.eks_node_min_size
  }

  launch_template {
   name = var.eks_launch_template_name
   version = var.eks_launch_template_version
  }
  disk_size = var.eks_node_disk_size
  release_version = var.eks_node_release_version
  dynamic "taint" {
     for_each = var.eks_nodegrp_taint
     content {
        key    = lookup(taint.value, "key", null)
        value  = lookup(taint.value, "value", null)
        effect = lookup(taint.value, "effect", null)
     }
  }
  labels =  var.eks_node_labels
  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [var.eks_node_role_policy_attachment]

  tags = merge(map(
  "Name", var.eks_node_group_name,
  ), var.eks_node_tags)
}
