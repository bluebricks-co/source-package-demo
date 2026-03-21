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

- S3 bucket with versioning enabled
- Server-side encryption (AES256)
- Public access blocked
- DynamoDB table for state locking (pay-per-request billing)

## Implementation

This module uses the following community modules:
- [terraform-aws-modules/s3-bucket/aws](https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws) (~> 5.11.0)
- [terraform-aws-modules/dynamodb-table/aws](https://registry.terraform.io/modules/terraform-aws-modules/dynamodb-table/aws) (~> 5.5.0)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| bucket_name | Name of the S3 bucket for Terraform state storage | string | "kubecon-demo-tf-state" | no |
| dynamodb_table_name | Name of the DynamoDB table for Terraform state locking | string | "kubecon-demo-tf-locks" | no |
| force_destroy | Allow destruction of S3 bucket even if it contains objects | bool | false | no |
| region | AWS region where resources will be created | string | "eu-central-1" | no |
| tags | Additional tags to apply to all resources | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_name | Name of the S3 bucket for Terraform state |
| bucket_arn | ARN of the S3 bucket for Terraform state |
| dynamodb_table_name | Name of the DynamoDB table for state locking |
| dynamodb_table_arn | ARN of the DynamoDB table for state locking |
| backend_config | Terraform backend configuration snippet |
