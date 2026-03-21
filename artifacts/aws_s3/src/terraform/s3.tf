locals {
  default_tags = {
    ManagedBy = "bluebricks"
    Purpose   = "demo"
  }
  merged_tags = merge(local.default_tags, var.tags)
}

resource "aws_s3_bucket" "demo" {
  bucket = var.name
  tags   = local.merged_tags
}
