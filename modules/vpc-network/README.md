# vpc-network

Terraform module for creating a standalone VPC with public and private subnets, Internet Gateway, optional NAT Gateway, and route tables.

This module uses the community [terraform-aws-modules/vpc/aws](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws) module (~> 6.6.0).

## Features

- VPC with configurable CIDR block
- DNS support and DNS hostnames enabled
- Public subnets with auto-assign public IP
- Private subnets
- Internet Gateway for public subnet internet access
- Optional NAT Gateway for private subnet internet access
- Restrictive default security group

## Usage

```hcl
module "vpc_network" {
  source = "./modules/vpc-network"

  name                  = "kubecon-demo"
  vpc_cidr              = "10.0.0.0/16"
  public_subnet_cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs  = ["10.0.10.0/24", "10.0.11.0/24"]
  availability_zones    = ["eu-west-1a", "eu-west-1b"]
  enable_nat_gateway    = true
  region                = "eu-west-1"

  tags = {
    Environment = "demo"
    Project     = "kubecon"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | Name prefix for all resources in the VPC | string | "kubecon-demo" | no |
| region | AWS region to deploy resources | string | "eu-west-1" | no |
| tags | Common tags to apply to all resources | map(string) | {} | no |
| vpc_cidr | CIDR block for the VPC | string | "10.0.0.0/16" | no |
| public_subnet_cidrs | List of CIDR blocks for public subnets | list(string) | ["10.0.1.0/24", "10.0.2.0/24"] | no |
| private_subnet_cidrs | List of CIDR blocks for private subnets | list(string) | ["10.0.10.0/24", "10.0.11.0/24"] | no |
| availability_zones | List of availability zones for subnet placement | list(string) | ["eu-west-1a", "eu-west-1b"] | no |
| enable_nat_gateway | Whether to create a NAT Gateway for private subnet internet access | bool | true | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | ID of the VPC |
| public_subnet_ids | List of public subnet IDs |
| private_subnet_ids | List of private subnet IDs |
| nat_gateway_id | ID of the NAT Gateway (if enabled) |
| igw_id | ID of the Internet Gateway |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 5.70.0 |
