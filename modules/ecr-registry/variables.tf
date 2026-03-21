variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "eu-west-1"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
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
