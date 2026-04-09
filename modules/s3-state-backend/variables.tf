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
  default     = "eu-central-1"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags to apply to all resources"
  default     = {}
}

# S3 Versioning
variable "versioning_enabled" {
  type        = bool
  description = "Enable versioning for the S3 bucket"
  default     = false
}

variable "versioning_mfa_delete" {
  type        = bool
  description = "Enable MFA delete for versioned objects"
  default     = false
}

# S3 Encryption
variable "sse_algorithm" {
  type        = string
  description = "Server-side encryption algorithm (AES256 or aws:kms)"
  default     = "AES256"
}

variable "kms_master_key_id" {
  type        = string
  description = "KMS key ID for server-side encryption (required if sse_algorithm is aws:kms)"
  default     = null
}

variable "bucket_key_enabled" {
  type        = bool
  description = "Enable S3 Bucket Key for SSE-KMS"
  default     = false
}

# S3 Lifecycle
variable "lifecycle_rule" {
  type        = any
  description = "List of lifecycle rules for the S3 bucket"
  default     = []
}

# S3 Logging
variable "logging_enabled" {
  type        = bool
  description = "Enable access logging for the S3 bucket"
  default     = false
}

variable "logging_target_bucket" {
  type        = string
  description = "Target bucket for access logs"
  default     = null
}

variable "logging_target_prefix" {
  type        = string
  description = "Prefix for access log objects"
  default     = "log/"
}

# S3 Object Lock
variable "object_lock_enabled" {
  type        = bool
  description = "Enable S3 Object Lock (requires versioning)"
  default     = false
}

variable "object_lock_configuration" {
  type        = any
  description = "Object Lock configuration for the S3 bucket"
  default     = {}
}

# DynamoDB Billing
variable "billing_mode" {
  type        = string
  description = "DynamoDB billing mode (PROVISIONED or PAY_PER_REQUEST)"
  default     = "PAY_PER_REQUEST"
}

variable "read_capacity" {
  type        = number
  description = "Read capacity units (required if billing_mode is PROVISIONED)"
  default     = null
}

variable "write_capacity" {
  type        = number
  description = "Write capacity units (required if billing_mode is PROVISIONED)"
  default     = null
}

# DynamoDB Point-in-Time Recovery
variable "point_in_time_recovery_enabled" {
  type        = bool
  description = "Enable point-in-time recovery for DynamoDB table"
  default     = false
}

# DynamoDB Deletion Protection
variable "deletion_protection_enabled" {
  type        = bool
  description = "Enable deletion protection for DynamoDB table"
  default     = null
}

# DynamoDB Encryption
variable "dynamodb_server_side_encryption_enabled" {
  type        = bool
  description = "Enable server-side encryption for DynamoDB table"
  default     = false
}

variable "dynamodb_kms_key_arn" {
  type        = string
  description = "KMS key ARN for DynamoDB encryption"
  default     = null
}

# DynamoDB Table Class
variable "table_class" {
  type        = string
  description = "DynamoDB table class (STANDARD or STANDARD_INFREQUENT_ACCESS)"
  default     = null
}
