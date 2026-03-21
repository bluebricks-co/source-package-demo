# EKS Auto Mode Module

This Terraform module creates a fully self-contained EKS Auto Mode cluster with its own VPC, subnets, and IAM roles using community-maintained Terraform modules.

## Features

- EKS Auto Mode cluster with compute auto-scaling
- VPC with public and private subnets across 2 availability zones (using terraform-aws-modules/vpc/aws)
- NAT Gateway for private subnet internet access
- IAM roles for cluster and node management
- Elastic Load Balancing support
- Block storage support
- Uses community-maintained modules for better maintainability

## Usage

```hcl
module "eks_automode" {
  source = "./modules/eks-automode"

  cluster_name            = "my-cluster"
  cluster_version         = "1.31"
  vpc_cidr                = "10.0.0.0/16"
  region                  = "eu-central-1"
  endpoint_private_access = true
  endpoint_public_access  = true

  tags = {
    Environment = "production"
    Team        = "platform"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| cluster_name | Name of the EKS cluster | `string` | `"kubecon-demo"` | no |
| cluster_version | Kubernetes version for the EKS cluster | `string` | `"1.31"` | no |
| vpc_cidr | CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| endpoint_private_access | Enable private API server endpoint | `bool` | `true` | no |
| endpoint_public_access | Enable public API server endpoint | `bool` | `true` | no |
| region | AWS region | `string` | `"eu-central-1"` | no |
| tags | Tags to apply to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster_endpoint | Endpoint for the EKS cluster API server |
| cluster_certificate_authority | Certificate authority data for the cluster |
| cluster_name | Name of the EKS cluster |
| oidc_issuer_url | OIDC issuer URL for the cluster |
| cluster_security_group_id | Security group ID attached to the cluster |
| vpc_id | ID of the VPC |
| private_subnet_ids | IDs of the private subnets |
| public_subnet_ids | IDs of the public subnets |

## Network Architecture

- **VPC**: Single VPC with configurable CIDR
- **Public Subnets**: 2 subnets with internet gateway access
- **Private Subnets**: 2 subnets with NAT gateway access
- **Availability Zones**: Resources spread across 2 AZs for high availability

## IAM Roles

The module creates two IAM roles:

1. **Cluster Role**: Used by the EKS control plane with the following policies:
   - AmazonEKSClusterPolicy
   - AmazonEKSComputePolicy
   - AmazonEKSBlockStoragePolicy
   - AmazonEKSLoadBalancingPolicy
   - AmazonEKSNetworkingPolicy

2. **Node Role**: Used by worker nodes with the following policies:
   - AmazonEKSWorkerNodeMinimalPolicy
   - AmazonEC2ContainerRegistryPullOnly

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 5.70.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| vpc | terraform-aws-modules/vpc/aws | ~> 6.6.0 |

Note: The EKS cluster uses the raw `aws_eks_cluster` resource instead of the terraform-aws-modules/eks/aws module because Auto Mode is a very new feature not yet supported by the community module.
