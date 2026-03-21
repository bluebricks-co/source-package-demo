module "s3" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 5.11.0"

  bucket              = var.bucket_name
  force_destroy       = var.force_destroy
  object_lock_enabled = var.object_lock_enabled

  versioning = {
    enabled    = var.versioning_enabled
    mfa_delete = var.versioning_mfa_delete
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm     = var.sse_algorithm
        kms_master_key_id = var.kms_master_key_id
      }
      bucket_key_enabled = var.bucket_key_enabled
    }
  }

  lifecycle_rule = var.lifecycle_rule

  logging = var.logging_enabled ? {
    target_bucket = var.logging_target_bucket
    target_prefix = var.logging_target_prefix
  } : {}

  object_lock_configuration = var.object_lock_configuration

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  tags = var.tags
}

module "dynamodb" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "~> 5.5.0"

  name                           = var.dynamodb_table_name
  billing_mode                   = var.billing_mode
  read_capacity                  = var.read_capacity
  write_capacity                 = var.write_capacity
  hash_key                       = "LockID"
  point_in_time_recovery_enabled = var.point_in_time_recovery_enabled
  deletion_protection_enabled    = var.deletion_protection_enabled
  server_side_encryption_enabled = var.dynamodb_server_side_encryption_enabled
  server_side_encryption_kms_key_arn = var.dynamodb_kms_key_arn
  table_class                    = var.table_class

  attributes = [
    {
      name = "LockID"
      type = "S"
    }
  ]

  tags = var.tags
}
