output "role_arn" {
  description = "ARN of the IAM role for EKS Pod Identity"
  value       = module.iam_role.arn
}

output "role_name" {
  description = "Name of the IAM role for EKS Pod Identity"
  value       = module.iam_role.name
}

output "role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.iam_role.unique_id
}

output "custom_policy_arn" {
  description = "ARN of the custom IAM policy (if created)"
  value       = var.custom_policy_json != null ? aws_iam_policy.custom[0].arn : null
}

output "custom_policy_id" {
  description = "ID of the custom IAM policy (if created)"
  value       = var.custom_policy_json != null ? aws_iam_policy.custom[0].id : null
}
