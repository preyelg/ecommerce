output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS Cluster API endpoint"
  value       = module.eks.cluster_endpoint
}

output "node_group_role_arn" {
  description = "IAM Role ARN for the default node group"
  value       = module.eks.eks_managed_node_groups.default.iam_role_arn
}

output "kubeconfig" {
  description = "Kubeconfig context name (same as cluster name)"
  value       = module.eks.cluster_name
}
