module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 3.2.0"

  repository_name = var.repository_name
  repository_type = var.repository_type

  repository_image_tag_mutability = var.image_tag_mutability
  repository_image_scan_on_push   = var.scan_on_push
  repository_force_delete         = var.force_delete

  repository_encryption_type = var.repository_encryption_type
  repository_kms_key         = var.repository_kms_key

  repository_policy = var.repository_policy

  create_lifecycle_policy = var.create_lifecycle_policy
  repository_lifecycle_policy = var.create_lifecycle_policy ? jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images after ${var.untagged_expiry_days} days"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = var.untagged_expiry_days
        }
        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 2
        description  = "Keep last ${var.max_image_count} tagged images"
        selection = {
          tagStatus     = "tagged"
          tagPrefixList = ["v"]
          countType     = "imageCountMoreThan"
          countNumber   = var.max_image_count
        }
        action = {
          type = "expire"
        }
      }
    ]
  }) : null

  repository_read_access_arns        = var.repository_read_access_arns
  repository_lambda_read_access_arns = var.repository_lambda_read_access_arns
  repository_read_write_access_arns  = var.repository_read_write_access_arns

  manage_registry_scanning_configuration = var.manage_registry_scanning_configuration
  registry_scan_type                     = var.registry_scan_type
  registry_scan_rules                    = var.registry_scan_rules

  registry_pull_through_cache_rules = var.registry_pull_through_cache_rules

  create_registry_replication_configuration = var.create_registry_replication_configuration
  registry_replication_rules                = var.registry_replication_rules

  public_repository_catalog_data = var.public_repository_catalog_data

  tags = var.tags
}
