resource "aws_s3_bucket" "demo" {
  bucket = var.name
  tags = {
    Name = var.name
    env = "demo"
  }
}
