resource "aws_s3_bucket" "demo" {
  bucket = var.name
  tags = var.tags
}
