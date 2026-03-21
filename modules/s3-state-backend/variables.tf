variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket for Terraform state storage"
  default     = "dam-tf-state"
}

variable "dynamodb_table_name" {
  type        = string
  description = "Name of the DynamoDB table for Terraform state locking"
  default     = "dam-tf-locks"
}

variable "force_destroy" {
  type        = bool
  description = "Allow destruction of S3 bucket even if it contains objects"
  default     = false
}

variable "region" {
  type        = string
  description = "AWS region where resources will be created"
  default     = "eu-west-1"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags to apply to all resources"
  default     = {}
}
