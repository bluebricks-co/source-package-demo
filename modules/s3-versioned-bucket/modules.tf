module "s3" {
  for_each       = toset(var.bucket_names)
  source         = "terraform-aws-modules/s3-bucket/aws"
  bucket         = each.value
  cors_rule      = var.cors_rule
  create_bucket  = var.create_bucket
  lifecycle_rule = var.lifecycle_rule
  logging        = var.logging
  version        = "~> 4.1"
  versioning     = var.versioning
}
