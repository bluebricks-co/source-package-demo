provider "aws" {
  default_tags {
    tags = {}
  }

  region = var.region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.70.0"
    }
  }

  required_version = ">= 1.0"
}
