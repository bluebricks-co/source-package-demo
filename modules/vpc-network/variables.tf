variable "name" {
  description = "Name prefix for all resources in the VPC"
  type        = string
  default     = "dam-network-nik"
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-central-1"
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/15"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "VPC CIDR must be a valid IPv4 CIDR block."
  }
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones for subnet placement"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "enable_nat_gateway" {
  description = "Whether to create a NAT Gateway for private subnet internet access"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Whether to provision a single shared NAT Gateway across all private networks"
  type        = bool
  default     = true
}

variable "map_public_ip_on_launch" {
  description = "Whether to auto-assign public IP addresses to instances launched in public subnets"
  type        = bool
  default     = true
}

variable "enable_flow_log" {
  description = "Whether to enable VPC Flow Logs"
  type        = bool
  default     = false
}

variable "flow_log_destination_type" {
  description = "Type of flow log destination. Can be s3, kinesis-data-firehose or cloud-watch-logs"
  type        = string
  default     = "cloud-watch-logs"
}

variable "create_flow_log_cloudwatch_log_group" {
  description = "Whether to create CloudWatch log group for VPC Flow Logs"
  type        = bool
  default     = false
}

variable "create_flow_log_cloudwatch_iam_role" {
  description = "Whether to create IAM role for VPC Flow Logs"
  type        = bool
  default     = false
}

variable "flow_log_cloudwatch_log_group_retention_in_days" {
  description = "Number of days to retain VPC flow logs in CloudWatch"
  type        = number
  default     = 7
}

variable "flow_log_traffic_type" {
  description = "The type of traffic to capture in VPC Flow Logs. Valid values: ACCEPT, REJECT, ALL"
  type        = string
  default     = "ALL"
}

variable "flow_log_max_aggregation_interval" {
  description = "Maximum interval of time during which a flow of packets is captured and aggregated. Valid values: 60 or 600 seconds"
  type        = number
  default     = 600
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = false
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = false
}

variable "enable_network_address_usage_metrics" {
  description = "Whether to enable Network Address Usage metrics for the VPC"
  type        = bool
  default     = true
}

variable "enable_ipv6" {
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC"
  type        = bool
  default     = true
}
