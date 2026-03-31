module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.6.0"

  name = var.name
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  public_subnets  = var.public_subnet_cidrs
  private_subnets = var.private_subnet_cidrs

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway

  map_public_ip_on_launch = var.map_public_ip_on_launch

  enable_dns_support   = true

  manage_default_security_group  = true
  default_security_group_ingress = []
  default_security_group_egress  = []

  # VPC Flow Logs
  enable_flow_log                                 = true
  flow_log_destination_type                       = var.flow_log_destination_type
  create_flow_log_cloudwatch_log_group            = var.create_flow_log_cloudwatch_log_group
  create_flow_log_cloudwatch_iam_role             = var.create_flow_log_cloudwatch_iam_role
  flow_log_cloudwatch_log_group_retention_in_days = var.flow_log_cloudwatch_log_group_retention_in_days
  flow_log_traffic_type                           = var.flow_log_traffic_type
  flow_log_max_aggregation_interval               = var.flow_log_max_aggregation_interval

  tags = var.tags
}
