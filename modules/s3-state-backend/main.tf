provider "aws" {
  region = var.region

  default_tags {
    tags = var.tags
  }
}

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.70.0"
    }
  }
}

resource "aws_kms_key" "tf_state" {
  description             = "KMS key for Terraform state bucket encryption: ${var.bucket_name}"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = var.tags
}

resource "aws_kms_alias" "tf_state" {
  name          = "alias/tf-state-${var.bucket_name}"
  target_key_id = aws_kms_key.tf_state.key_id
}
