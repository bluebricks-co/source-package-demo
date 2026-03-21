output "cluster_endpoint" {
  description = "Endpoint for the EKS cluster API server"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "argocd_arn" {
  description = "ARN of the ArgoCD EKS capability"
  value       = module.argocd.arn
}

output "argocd_server_url" {
  description = "URL of the ArgoCD server"
  value       = module.argocd.argocd_server_url
}

output "argocd_iam_role_arn" {
  description = "ARN of the IAM role used by ArgoCD"
  value       = module.argocd.iam_role_arn
}

output "kubeconfig_command" {
  description = "Command to configure kubectl for this cluster"
  value       = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.region}"
}
