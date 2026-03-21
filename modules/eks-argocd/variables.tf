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

variable "argocd_addon_version" {
  type        = string
  description = "Version of the ArgoCD EKS add-on (null for latest)"
  default     = null
}

variable "node_instance_type" {
  type        = string
  description = "EC2 instance type for EKS worker nodes"
  default     = "t3.medium"
}

variable "node_desired_size" {
  type        = number
  description = "Desired number of worker nodes"
  default     = 2

  validation {
    condition     = var.node_desired_size > 0
    error_message = "Node desired size must be greater than 0."
  }
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
