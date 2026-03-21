# ECR Registry Module

This module creates an AWS ECR repository with lifecycle policies and image scanning using the community module `terraform-aws-modules/ecr/aws`.

## Features

- Public or private repository types
- Configurable image tag mutability (MUTABLE or IMMUTABLE)
- Automatic image scanning on push
- KMS or AES256 encryption
- Cross-account access via repository policies
- Lifecycle policies to manage image retention:
  - Expires untagged images after a configurable number of days
  - Keeps only the last N tagged images
- Registry-level scanning configuration (BASIC or ENHANCED)
- Pull-through cache rules for upstream registries
- Cross-region replication support
- Public repository catalog data configuration

## Usage

### Basic Private Repository

```hcl
module "ecr_registry" {
  source = "./modules/ecr-registry"

  repository_name       = "my-app"
  image_tag_mutability  = "IMMUTABLE"
  scan_on_push          = true
  max_image_count       = 30
  untagged_expiry_days  = 14
  force_delete          = false

  region = "eu-central-1"
  tags = {
    Environment = "production"
    ManagedBy   = "terraform"
  }
}
```

### Repository with KMS Encryption

```hcl
module "ecr_registry" {
  source = "./modules/ecr-registry"

  repository_name          = "my-app"
  repository_encryption_type = "KMS"
  repository_kms_key       = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"
}
```

### Repository with Cross-Account Access

```hcl
module "ecr_registry" {
  source = "./modules/ecr-registry"

  repository_name = "my-app"

  repository_read_access_arns = [
    "arn:aws:iam::123456789012:role/CrossAccountReadRole"
  ]

  repository_read_write_access_arns = [
    "arn:aws:iam::123456789012:role/CrossAccountWriteRole"
  ]
}
```

### Registry with Enhanced Scanning

```hcl
module "ecr_registry" {
  source = "./modules/ecr-registry"

  repository_name = "my-app"

  manage_registry_scanning_configuration = true
  registry_scan_type                     = "ENHANCED"
  registry_scan_rules = [
    {
      scan_frequency = "SCAN_ON_PUSH"
      filter = [
        {
          filter      = "*"
          filter_type = "WILDCARD"
        }
      ]
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| repository_name | Name of the ECR repository | string | "tulip-app" | no |
| repository_type | The type of repository to create. Either 'public' or 'private' | string | "private" | no |
| image_tag_mutability | Image tag mutability setting (MUTABLE or IMMUTABLE) | string | "IMMUTABLE" | no |
| scan_on_push | Enable image scanning on push | bool | true | no |
| max_image_count | Maximum number of tagged images to keep | number | 30 | no |
| untagged_expiry_days | Number of days before untagged images expire | number | 14 | no |
| force_delete | Allow deletion of repository even if it contains images | bool | false | no |
| repository_encryption_type | The encryption type for the repository. Must be one of: 'KMS' or 'AES256' | string | "AES256" | no |
| repository_kms_key | The ARN of the KMS key to use when encryption_type is 'KMS' | string | null | no |
| repository_policy | The JSON policy to apply to the repository for cross-account access | string | null | no |
| create_lifecycle_policy | Determines whether a lifecycle policy will be created | bool | true | no |
| repository_read_access_arns | The ARNs of the IAM users/roles that have read access to the repository | list(string) | [] | no |
| repository_lambda_read_access_arns | The ARNs of the Lambda service roles that have read access to the repository | list(string) | [] | no |
| repository_read_write_access_arns | The ARNs of the IAM users/roles that have read/write access to the repository | list(string) | [] | no |
| manage_registry_scanning_configuration | Determines whether the registry scanning configuration will be managed | bool | false | no |
| registry_scan_type | The scanning type to set for the registry. Can be either 'ENHANCED' or 'BASIC' | string | "ENHANCED" | no |
| registry_scan_rules | Scanning rules to determine which repository filters are used and at what frequency | list(object) | [] | no |
| registry_pull_through_cache_rules | List of pull through cache rules to create | map(object) | {} | no |
| create_registry_replication_configuration | Determines whether a registry replication configuration will be created | bool | false | no |
| registry_replication_rules | The replication rules for a replication configuration | list(object) | [] | no |
| public_repository_catalog_data | Catalog data configuration for the repository (only applicable for public repositories) | object | null | no |
| region | AWS region where resources will be created | string | "eu-central-1" | no |
| tags | Tags to apply to all resources | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| repository_url | URL of the ECR repository |
| repository_arn | ARN of the ECR repository |
| registry_id | Registry ID where the repository was created |
| repository_name | Name of the ECR repository |

## Lifecycle Policy

The module automatically configures two lifecycle rules when `create_lifecycle_policy` is enabled:

1. **Untagged Images**: Expires untagged images after the specified number of days (default: 14 days)
2. **Tagged Images**: Keeps only the last N tagged images with "v" prefix (default: 30 images)
