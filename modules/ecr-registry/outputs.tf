output "repository_url" {
  description = "URL of the ECR repository"
  value       = module.ecr.repository_url
}

output "repository_arn" {
  description = "ARN of the ECR repository"
  value       = module.ecr.repository_arn
}

output "registry_id" {
  description = "Registry ID where the repository was created"
  value       = module.ecr.repository_registry_id
}
