variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "eu-central-1"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {
    kiv_test = "kiv_test"
  }
}

variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "tulip-app"
}

variable "image_tag_mutability" {
  description = "Image tag mutability setting (MUTABLE or IMMUTABLE)"
  type        = string
  default     = "IMMUTABLE"

  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "image_tag_mutability must be either MUTABLE or IMMUTABLE"
  }
}

variable "scan_on_push" {
  description = "Enable image scanning on push"
  type        = bool
  default     = true
}

variable "max_image_count" {
  description = "Maximum number of tagged images to keep"
  type        = number
  default     = 30

  validation {
    condition     = var.max_image_count > 0
    error_message = "max_image_count must be greater than 0"
  }
}

variable "untagged_expiry_days" {
  description = "Number of days before untagged images expire"
  type        = number
  default     = 14

  validation {
    condition     = var.untagged_expiry_days > 0
    error_message = "untagged_expiry_days must be greater than 0"
  }
}

variable "force_delete" {
  description = "Allow deletion of repository even if it contains images"
  type        = bool
  default     = false
}

variable "repository_type" {
  description = "The type of repository to create. Either 'public' or 'private'"
  type        = string
  default     = "private"

  validation {
    condition     = contains(["public", "private"], var.repository_type)
    error_message = "repository_type must be either 'public' or 'private'"
  }
}

variable "repository_encryption_type" {
  description = "The encryption type for the repository. Must be one of: 'KMS' or 'AES256'"
  type        = string
  default     = "AES256"

  validation {
    condition     = contains(["KMS", "AES256"], var.repository_encryption_type)
    error_message = "repository_encryption_type must be either 'KMS' or 'AES256'"
  }
}

variable "repository_kms_key" {
  description = "The ARN of the KMS key to use when encryption_type is 'KMS'. If not specified, uses the default AWS managed key for ECR"
  type        = string
  default     = null
}

variable "repository_policy" {
  description = "The JSON policy to apply to the repository for cross-account access. If not specified, uses the default policy"
  type        = string
  default     = null
}

variable "create_lifecycle_policy" {
  description = "Determines whether a lifecycle policy will be created"
  type        = bool
  default     = true
}

variable "repository_read_access_arns" {
  description = "The ARNs of the IAM users/roles that have read access to the repository"
  type        = list(string)
  default     = []
}

variable "repository_lambda_read_access_arns" {
  description = "The ARNs of the Lambda service roles that have read access to the repository"
  type        = list(string)
  default     = []
}

variable "repository_read_write_access_arns" {
  description = "The ARNs of the IAM users/roles that have read/write access to the repository"
  type        = list(string)
  default     = []
}

variable "manage_registry_scanning_configuration" {
  description = "Determines whether the registry scanning configuration will be managed"
  type        = bool
  default     = false
}

variable "registry_scan_type" {
  description = "The scanning type to set for the registry. Can be either 'ENHANCED' or 'BASIC'"
  type        = string
  default     = "ENHANCED"

  validation {
    condition     = contains(["ENHANCED", "BASIC"], var.registry_scan_type)
    error_message = "registry_scan_type must be either 'ENHANCED' or 'BASIC'"
  }
}

variable "registry_scan_rules" {
  description = "One or multiple blocks specifying scanning rules to determine which repository filters are used and at what frequency scanning will occur"
  type = list(object({
    scan_frequency = string
    filter = list(object({
      filter      = string
      filter_type = optional(string)
    }))
  }))
  default = []
}

variable "registry_pull_through_cache_rules" {
  description = "List of pull through cache rules to create"
  type = map(object({
    ecr_repository_prefix      = string
    upstream_registry_url      = string
    credential_arn             = optional(string)
    custom_role_arn            = optional(string)
    upstream_repository_prefix = optional(string)
  }))
  default = {}
}

variable "create_registry_replication_configuration" {
  description = "Determines whether a registry replication configuration will be created"
  type        = bool
  default     = false
}

variable "registry_replication_rules" {
  description = "The replication rules for a replication configuration. A maximum of 10 are allowed"
  type = list(object({
    destinations = list(object({
      region      = string
      registry_id = string
    }))
    repository_filters = optional(list(object({
      filter      = string
      filter_type = string
    })))
  }))
  default = []
}

variable "public_repository_catalog_data" {
  description = "Catalog data configuration for the repository (only applicable for public repositories)"
  type = object({
    about_text        = optional(string)
    architectures     = optional(list(string))
    description       = optional(string)
    operating_systems = optional(list(string))
    usage_text        = optional(string)
  })
  default = null
}
