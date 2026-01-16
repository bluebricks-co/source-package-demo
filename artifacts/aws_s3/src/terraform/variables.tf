
variable "acl" {
  default     = "private"
  description = "The canned ACL to apply"
  type        = string
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


variable "name" {
  description = "The S3 bucket name"
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


variable "force_destroy" {
  default     = false
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error"
  type        = bool
}


variable "ignore_public_acls" {
  default     = true
  description = "Whether Amazon S3 should ignore public ACLs for this bucket"
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


variable "region" {
  type = string
}


variable "restrict_public_buckets" {
  default     = true
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket"
  type        = bool
}


variable "server_side_encryption_configuration" {
  default     = {}
  description = "Map containing server-side encryption configuration."
  type        = any
}


variable "versioning" {
  default = true
  description = "Versioning configuration block"
  type        = bool
}


