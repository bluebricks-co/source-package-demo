# KMS Key Outputs
output "kms_key_id" {
  description = "ID of the KMS key used for S3 bucket encryption"
  value       = aws_kms_key.tf_state.key_id
}

output "kms_key_arn" {
  description = "ARN of the KMS key used for S3 bucket encryption"
  value       = aws_kms_key.tf_state.arn
}

output "kms_key_alias" {
  description = "Alias of the KMS key used for S3 bucket encryption"
  value       = aws_kms_alias.tf_state.name
}

# S3 Bucket Outputs
output "bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  value       = module.s3.s3_bucket_id
}

output "bucket_arn" {
  description = "ARN of the S3 bucket for Terraform state"
  value       = module.s3.s3_bucket_arn
}

output "bucket_domain_name" {
  description = "Bucket domain name"
  value       = module.s3.s3_bucket_bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "Bucket region-specific domain name"
  value       = module.s3.s3_bucket_bucket_regional_domain_name
}

output "bucket_region" {
  description = "AWS region of the S3 bucket"
  value       = module.s3.s3_bucket_region
}

output "bucket_hosted_zone_id" {
  description = "Route 53 Hosted Zone ID for the bucket's region"
  value       = module.s3.s3_bucket_hosted_zone_id
}

output "bucket_versioning_status" {
  description = "Versioning status of the bucket"
  value       = module.s3.aws_s3_bucket_versioning_status
}

output "bucket_lifecycle_rules" {
  description = "Lifecycle rules of the bucket"
  value       = module.s3.s3_bucket_lifecycle_configuration_rules
}

output "bucket_policy" {
  description = "Policy of the bucket"
  value       = module.s3.s3_bucket_policy
}

# DynamoDB Table Outputs
output "dynamodb_table_name" {
  description = "Name of the DynamoDB table for state locking"
  value       = module.dynamodb.dynamodb_table_id
}

output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table for state locking"
  value       = module.dynamodb.dynamodb_table_arn
}

output "dynamodb_table_stream_arn" {
  description = "ARN of the DynamoDB table stream"
  value       = module.dynamodb.dynamodb_table_stream_arn
}

output "dynamodb_table_stream_label" {
  description = "Timestamp of the DynamoDB table stream"
  value       = module.dynamodb.dynamodb_table_stream_label
}

# Backend Configuration
output "backend_config" {
  description = "Terraform backend configuration snippet"
  value       = <<-EOT
    terraform {
      backend "s3" {
        bucket         = "${module.s3.s3_bucket_id}"
        key            = "path/to/terraform.tfstate"
        region         = "${var.region}"
        dynamodb_table = "${module.dynamodb.dynamodb_table_id}"
        encrypt        = true
      }
    }
  EOT
}
