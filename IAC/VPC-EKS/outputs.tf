output "cluster_name" {
  description = "The name/id of the EKS cluster."
  value       = module.eks.cluster_name
}

output "VPC_ID" {
    description = "VPC ID of the cluster"
    value = module.vpc.vpc_id
}

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster."
  value       = module.eks.cluster_arn
}

output "cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = module.eks.cluster_endpoint
}

output "cluster_version" {
  description = "The Kubernetes server version for the EKS cluster."
  value       = module.eks.cluster_version
}

output "cluster_iam_role_name" {
  description = "IAM role name of the EKS cluster."
  value       = module.eks.cluster_iam_role_name 
}

output "cluster_iam_role_arn" {
  description = "IAM role ARN of the EKS cluster."
  value       = module.eks.cluster_iam_role_arn
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  value       = module.eks.cluster_oidc_issuer_url
}

output "eks_managed_node_groups" {
    description = "Map of attribute maps for all EKS managed node groups created"
    value = module.eks.eks_managed_node_groups
}

