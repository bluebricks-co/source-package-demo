output "bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  value       = module.s3.s3_bucket_id
}

output "bucket_arn" {
  description = "ARN of the S3 bucket for Terraform state"
  value       = module.s3.s3_bucket_arn
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table for state locking"
  value       = module.dynamodb.dynamodb_table_id
}

output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table for state locking"
  value       = module.dynamodb.dynamodb_table_arn
}

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
