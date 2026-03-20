resource "aws_s3_bucket" "demo" {
  bucket = var.name
  tags = var.tags
}

resource "aws_s3_bucket_versioning" "demo" {
  bucket = aws_s3_bucket.demo.id

  versioning_configuration {
    status = "Enabled" # enabled by Bluebricks
  }
}
