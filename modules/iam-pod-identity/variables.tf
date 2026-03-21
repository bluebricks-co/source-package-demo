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

variable "role_name" {
  description = "Name of the IAM role for EKS Pod Identity"
  type        = string
  default     = "windmill-pod-role"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_+=,.@-]{1,64}$", var.role_name))
    error_message = "Role name must be between 1 and 64 characters and contain only alphanumeric characters and the following: _+=,.@-"
  }
}

variable "policy_arns" {
  description = "List of IAM policy ARNs to attach to the role"
  type        = list(string)
  default     = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]

  validation {
    condition     = alltrue([for arn in var.policy_arns : can(regex("^arn:aws:iam::", arn))])
    error_message = "All policy ARNs must be valid IAM policy ARNs starting with 'arn:aws:iam::'"
  }
}

variable "custom_policy_json" {
  description = "Custom IAM policy JSON document to attach to the role. If null, no custom policy is created."
  type        = string
  default     = null

  validation {
    condition     = var.custom_policy_json == null || can(jsondecode(var.custom_policy_json))
    error_message = "custom_policy_json must be a valid JSON string or null"
  }
}
