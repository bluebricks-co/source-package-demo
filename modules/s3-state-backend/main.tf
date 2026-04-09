provider "aws" {
  region = var.region

  default_tags {
    tags = merge(var.tags, {
      Owner = "BLUEBRICKS"
    })
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
