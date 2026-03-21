# ECR Registry Module

This module creates an AWS ECR repository with lifecycle policies and image scanning using the community module `terraform-aws-modules/ecr/aws`.

## Features

- Configurable image tag mutability (MUTABLE or IMMUTABLE)
- Automatic image scanning on push
- Lifecycle policies to manage image retention:
  - Expires untagged images after a configurable number of days
  - Keeps only the last N tagged images

## Usage

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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| repository_name | Name of the ECR repository | string | "kubecon-demo-app" | no |
| image_tag_mutability | Image tag mutability setting (MUTABLE or IMMUTABLE) | string | "IMMUTABLE" | no |
| scan_on_push | Enable image scanning on push | bool | true | no |
| max_image_count | Maximum number of tagged images to keep | number | 30 | no |
| untagged_expiry_days | Number of days before untagged images expire | number | 14 | no |
| force_delete | Allow deletion of repository even if it contains images | bool | false | no |
| region | AWS region where resources will be created | string | "eu-central-1" | no |
| tags | Tags to apply to all resources | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| repository_url | URL of the ECR repository |
| repository_arn | ARN of the ECR repository |
| registry_id | Registry ID where the repository was created |

## Lifecycle Policy

The module automatically configures two lifecycle rules:

1. **Untagged Images**: Expires untagged images after the specified number of days (default: 14 days)
2. **Tagged Images**: Keeps only the last N tagged images with "v" prefix (default: 30 images)
