
module "s3" {
  bucket         = var.name
  cors_rule      = var.cors_rule
  create_bucket  = var.create_bucket
  lifecycle_rule = var.lifecycle_rule
  logging        = var.logging
  source         = "terraform-aws-modules/s3-bucket/aws"
  version        = "~> 4.1"
  versioning     = {
    enabled = var.versioning
  }
}

