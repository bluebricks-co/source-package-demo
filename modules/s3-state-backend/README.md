# s3-state-backend

Terraform module for creating an S3 bucket and DynamoDB table for Terraform remote state storage and locking.

## Usage

```hcl
module "tf_state_backend" {
  source = "./modules/s3-state-backend"

  bucket_name          = "my-terraform-state"
  dynamodb_table_name  = "my-terraform-locks"
  region               = "eu-central-1"

  tags = {
    Environment = "production"
    ManagedBy   = "terraform"
  }
}
```

After creating the backend resources, configure your Terraform backend:

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "path/to/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "my-terraform-locks"
    encrypt        = true
  }
}
```

## Features

- S3 bucket with configurable versioning
- Configurable server-side encryption (AES256 or KMS)
- Public access blocked
- Configurable lifecycle rules
- Optional access logging
- Optional object lock
- DynamoDB table for state locking
- Configurable billing mode (pay-per-request or provisioned)
- Optional point-in-time recovery
- Optional deletion protection
- Optional server-side encryption for DynamoDB

## Implementation

This module uses the following community modules:
- [terraform-aws-modules/s3-bucket/aws](https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws) (~> 5.11.0)
- [terraform-aws-modules/dynamodb-table/aws](https://registry.terraform.io/modules/terraform-aws-modules/dynamodb-table/aws) (~> 5.5.0)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| bucket_name | Name of the S3 bucket for Terraform state storage | string | "dam-tf-state" | no |
| dynamodb_table_name | Name of the DynamoDB table for Terraform state locking | string | "dam-tf-locks" | no |
| force_destroy | Allow destruction of S3 bucket even if it contains objects | bool | false | no |
| region | AWS region where resources will be created | string | "eu-central-1" | no |
| tags | Additional tags to apply to all resources | map(string) | {} | no |
| versioning_enabled | Enable versioning for the S3 bucket | bool | true | no |
| versioning_mfa_delete | Enable MFA delete for versioned objects | bool | false | no |
| sse_algorithm | Server-side encryption algorithm (AES256 or aws:kms) | string | "AES256" | no |
| kms_master_key_id | KMS key ID for server-side encryption (required if sse_algorithm is aws:kms) | string | null | no |
| bucket_key_enabled | Enable S3 Bucket Key for SSE-KMS | bool | false | no |
| lifecycle_rule | List of lifecycle rules for the S3 bucket | any | [] | no |
| logging_enabled | Enable access logging for the S3 bucket | bool | false | no |
| logging_target_bucket | Target bucket for access logs | string | null | no |
| logging_target_prefix | Prefix for access log objects | string | "log/" | no |
| object_lock_enabled | Enable S3 Object Lock (requires versioning) | bool | false | no |
| object_lock_configuration | Object Lock configuration for the S3 bucket | any | {} | no |
| billing_mode | DynamoDB billing mode (PROVISIONED or PAY_PER_REQUEST) | string | "PAY_PER_REQUEST" | no |
| read_capacity | Read capacity units (required if billing_mode is PROVISIONED) | number | null | no |
| write_capacity | Write capacity units (required if billing_mode is PROVISIONED) | number | null | no |
| point_in_time_recovery_enabled | Enable point-in-time recovery for DynamoDB table | bool | false | no |
| deletion_protection_enabled | Enable deletion protection for DynamoDB table | bool | null | no |
| dynamodb_server_side_encryption_enabled | Enable server-side encryption for DynamoDB table | bool | false | no |
| dynamodb_kms_key_arn | KMS key ARN for DynamoDB encryption | string | null | no |
| table_class | DynamoDB table class (STANDARD or STANDARD_INFREQUENT_ACCESS) | string | null | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_name | Name of the S3 bucket for Terraform state |
| bucket_arn | ARN of the S3 bucket for Terraform state |
| bucket_domain_name | Bucket domain name |
| bucket_regional_domain_name | Bucket region-specific domain name |
| bucket_region | AWS region of the S3 bucket |
| bucket_hosted_zone_id | Route 53 Hosted Zone ID for the bucket's region |
| bucket_versioning_status | Versioning status of the bucket |
| bucket_lifecycle_rules | Lifecycle rules of the bucket |
| bucket_policy | Policy of the bucket |
| dynamodb_table_name | Name of the DynamoDB table for state locking |
| dynamodb_table_arn | ARN of the DynamoDB table for state locking |
| dynamodb_table_stream_arn | ARN of the DynamoDB table stream |
| dynamodb_table_stream_label | Timestamp of the DynamoDB table stream |
| backend_config | Terraform backend configuration snippet |
