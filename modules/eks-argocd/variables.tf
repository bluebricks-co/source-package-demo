variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
  default     = "tulip-argocd"

  validation {
    condition     = length(var.cluster_name) > 0 && length(var.cluster_name) <= 100
    error_message = "Cluster name must be between 1 and 100 characters."
  }
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version for the EKS cluster"
  default     = "1.34"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "VPC CIDR must be a valid IPv4 CIDR block."
  }
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Whether to create a NAT Gateway for private subnet internet access"
  default     = true
}

variable "single_nat_gateway" {
  type        = bool
  description = "Use a single NAT Gateway for all AZs (cost saving)"
  default     = true
}

variable "endpoint_public_access" {
  type        = bool
  description = "Enable public access to the EKS API server endpoint"
  default     = true
}

variable "node_pools" {
  type        = list(string)
  description = "List of Auto Mode node pools to enable"
  default     = ["general-purpose"]
}

variable "argocd_addon_version" {
  type        = string
  description = "Version of the ArgoCD EKS add-on (null for latest)"
  default     = null
}

variable "region" {
  type        = string
  description = "AWS region for resources"
  default     = "eu-central-1"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags to apply to all resources"
  default     = {}
}
