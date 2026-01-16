module "s3" {
  source                  = "terraform-aws-modules/s3-bucket/aws"
  version                 = "~> 4.1"
  attach_policy           = var.attach_policy
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  bucket                  = var.name
  cors_rule               = var.cors_rule
  create_bucket           = var.create_bucket
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
  lifecycle_rule          = var.lifecycle_rule
  logging                 = var.logging
  policy                  = var.policy
  versioning              = var.versioning
  website                 = var.website
  tags = var.tags
}
