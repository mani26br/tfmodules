output "eks_name" {
  value = "${aws_eks_cluster.eks_cluster.id}"
}

output "eks_endpoint" {
  value = "${aws_eks_cluster.eks_cluster.endpoint}"
}

output "eks_kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.eks_cluster.certificate_authority.0.data}"
}

output "eks_cluster_security_group_id" {
  value = "${aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id}"
}
