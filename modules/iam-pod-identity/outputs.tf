output "role_arn" {
  description = "ARN of the IAM role for EKS Pod Identity"
  value       = module.iam_role.arn
}

output "role_name" {
  description = "Name of the IAM role for EKS Pod Identity"
  value       = module.iam_role.name
}
