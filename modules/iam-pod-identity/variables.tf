variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "eu-central-1"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Tag     = "vika"
    weather = "rain"
  }
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

variable "use_name_prefix" {
  description = "Determines whether the IAM role name is used as a prefix"
  type        = bool
  default     = false
}

variable "path" {
  description = "Path of IAM role"
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the IAM role"
  type        = string
  default     = null
}

variable "max_session_duration" {
  description = "Maximum session duration (in seconds) for the role. Valid values: 3600 to 43200"
  type        = number
  default     = null
}

variable "permissions_boundary_arn" {
  description = "ARN of the policy that is used to set the permissions boundary for the IAM role"
  type        = string
  default     = null
}

variable "inline_policy_statements" {
  description = "Map of inline policy statements to add to the IAM role"
  type = map(object({
    sid           = optional(string)
    actions       = optional(list(string))
    not_actions   = optional(list(string))
    effect        = optional(string, "Allow")
    resources     = optional(list(string))
    not_resources = optional(list(string))
    principals = optional(list(object({
      type        = string
      identifiers = list(string)
    })), [])
    not_principals = optional(list(object({
      type        = string
      identifiers = list(string)
    })), [])
    conditions = optional(list(object({
      test     = string
      variable = string
      values   = list(string)
    })), [])
  }))
  default = {}
}

variable "trust_policy_conditions" {
  description = "Additional condition constraints for the trust policy"
  type = list(object({
    test     = string
    variable = string
    values   = list(string)
  }))
  default = []
}
