variable "attach_policy" {
  default     = false
  description = "Controls if S3 bucket should have bucket policy attached (set to `true` to use value of `policy` as bucket policy)"
  type        = bool
}

variable "block_public_acls" {
  default     = true
  description = "Whether Amazon S3 should block public ACLs for this bucket"
  type        = bool
}

variable "block_public_policy" {
  default     = true
  description = "Whether Amazon S3 should block public bucket policies for this bucket"
  type        = bool
}

variable "ignore_public_acls" {
  default     = true
  description = "Whether Amazon S3 should ignore public ACLs for this bucket"
  type        = bool
}

variable "restrict_public_buckets" {
  default     = true
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket"
  type        = bool
}

variable "name" {
  description = "The name of the bucket"
  type        = string
}

variable "cors_rule" {
  default     = []
  description = "Specifies the CORS configuration for the bucket"
  type        = any
}

variable "create_bucket" {
  default     = true
  description = "Controls if S3 bucket should be created"
  type        = bool
}

variable "lifecycle_rule" {
  default     = []
  description = "Specifies the lifecycle configuration for objects in the bucket"
  type        = any
}

variable "logging" {
  default     = {}
  description = "Map containing access bucket logging configuration."
  type        = map(string)
}

variable "policy" {
  default     = ""
  description = "A valid bucket policy JSON document"
  type        = string
}

variable "region" {
  type = string
  default = "eu-west-1"
}

variable "versioning" {
  default = {}
  description = "Versioning configuration block"
  type        = any
}

variable "website" {
  default     = {}
  description = "Map containing static web-site hosting or redirect configuration"
  type        = any
}

variable "tags" {
  default =  {}
  description = "A mapping of tags to assign to the bucket."
  type = map(string)
}
