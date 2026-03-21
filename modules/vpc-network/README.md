# vpc-network

Terraform module for creating a standalone VPC with public and private subnets, Internet Gateway, optional NAT Gateway, and route tables.

This module uses the community [terraform-aws-modules/vpc/aws](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws) module (~> 6.6.0).

## Features

- VPC with configurable CIDR block
- DNS support and DNS hostnames enabled
- Public subnets with configurable auto-assign public IP
- Private subnets
- Internet Gateway for public subnet internet access
- Optional NAT Gateway for private subnet internet access (single or per-AZ)
- Optional VPC Flow Logs to CloudWatch
- Restrictive default security group

## Usage

```hcl
module "vpc_network" {
  source = "./modules/vpc-network"

  name                  = "kubecon-demo"
  vpc_cidr              = "10.0.0.0/16"
  public_subnet_cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs  = ["10.0.10.0/24", "10.0.11.0/24"]
  availability_zones    = ["eu-central-1a", "eu-central-1b"]

  enable_nat_gateway    = true
  single_nat_gateway    = true
  map_public_ip_on_launch = true

  # Optional: Enable VPC Flow Logs
  enable_flow_log                                 = true
  create_flow_log_cloudwatch_log_group            = true
  create_flow_log_cloudwatch_iam_role             = true
  flow_log_cloudwatch_log_group_retention_in_days = 7

  region                = "eu-central-1"

  tags = {
    Environment = "demo"
    Project     = "kubecon"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | Name prefix for all resources in the VPC | string | "dam-network" | no |
| region | AWS region to deploy resources | string | "eu-central-1" | no |
| tags | Common tags to apply to all resources | map(string) | {} | no |
| vpc_cidr | CIDR block for the VPC | string | "10.0.0.0/16" | no |
| public_subnet_cidrs | List of CIDR blocks for public subnets | list(string) | ["10.0.1.0/24", "10.0.2.0/24"] | no |
| private_subnet_cidrs | List of CIDR blocks for private subnets | list(string) | ["10.0.10.0/24", "10.0.11.0/24"] | no |
| availability_zones | List of availability zones for subnet placement | list(string) | ["eu-central-1a", "eu-central-1b"] | no |
| enable_nat_gateway | Whether to create a NAT Gateway for private subnet internet access | bool | true | no |
| single_nat_gateway | Whether to provision a single shared NAT Gateway across all private networks | bool | true | no |
| map_public_ip_on_launch | Whether to auto-assign public IP addresses to instances launched in public subnets | bool | true | no |
| enable_flow_log | Whether to enable VPC Flow Logs | bool | false | no |
| flow_log_destination_type | Type of flow log destination (s3, kinesis-data-firehose, cloud-watch-logs) | string | "cloud-watch-logs" | no |
| create_flow_log_cloudwatch_log_group | Whether to create CloudWatch log group for VPC Flow Logs | bool | false | no |
| create_flow_log_cloudwatch_iam_role | Whether to create IAM role for VPC Flow Logs | bool | false | no |
| flow_log_cloudwatch_log_group_retention_in_days | Number of days to retain VPC flow logs in CloudWatch | number | 7 | no |
| flow_log_traffic_type | The type of traffic to capture in VPC Flow Logs (ACCEPT, REJECT, ALL) | string | "ALL" | no |
| flow_log_max_aggregation_interval | Maximum interval of time during which a flow of packets is captured (60 or 600 seconds) | number | 600 | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | ID of the VPC |
| vpc_arn | ARN of the VPC |
| vpc_cidr_block | CIDR block of the VPC |
| azs | List of availability zones used |
| public_subnet_ids | List of public subnet IDs |
| public_subnet_arns | List of ARNs of public subnets |
| public_subnets_cidr_blocks | List of CIDR blocks of public subnets |
| public_route_table_ids | List of IDs of public route tables |
| private_subnet_ids | List of private subnet IDs |
| private_subnet_arns | List of ARNs of private subnets |
| private_subnets_cidr_blocks | List of CIDR blocks of private subnets |
| private_route_table_ids | List of IDs of private route tables |
| nat_gateway_id | ID of the NAT Gateway (if enabled) |
| nat_gateway_ids | List of NAT Gateway IDs |
| nat_public_ips | List of public Elastic IPs created for NAT Gateways |
| igw_id | ID of the Internet Gateway |
| igw_arn | ARN of the Internet Gateway |
| default_security_group_id | ID of the default security group |
| default_network_acl_id | ID of the default network ACL |
| default_route_table_id | ID of the default route table |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 5.70.0 |
