# VPC Module - using community terraform-aws-modules/vpc/aws
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.6.0"

  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr

  azs             = ["${var.region}a", "${var.region}b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.10.0/24", "10.0.11.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}

# IAM role for EKS cluster with Auto Mode policies
data "aws_iam_policy_document" "cluster_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "cluster" {
  name               = "${var.cluster_name}-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.cluster_assume_role.json
}

locals {
  cluster_policies = {
    cluster_policy    = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    compute_policy    = "arn:aws:iam::aws:policy/AmazonEKSComputePolicy"
    block_storage     = "arn:aws:iam::aws:policy/AmazonEKSBlockStoragePolicy"
    load_balancing    = "arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy"
    networking_policy = "arn:aws:iam::aws:policy/AmazonEKSNetworkingPolicy"
  }
}

resource "aws_iam_role_policy_attachment" "cluster" {
  for_each = local.cluster_policies

  role       = aws_iam_role.cluster.name
  policy_arn = each.value
}

# IAM role for Auto Mode nodes
data "aws_iam_policy_document" "node_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "node" {
  name               = "${var.cluster_name}-node-role"
  assume_role_policy = data.aws_iam_policy_document.node_assume_role.json
}

locals {
  node_policies = {
    worker_node_minimal = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodeMinimalPolicy"
    ecr_pull_only       = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
  }
}

resource "aws_iam_role_policy_attachment" "node" {
  for_each = local.node_policies

  role       = aws_iam_role.node.name
  policy_arn = each.value
}

# EKS Auto Mode Cluster
# Note: terraform-aws-modules/eks/aws does not yet support Auto Mode configuration
# so we use the raw aws_eks_cluster resource with Auto Mode settings
resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.cluster.arn

  access_config {
    authentication_mode = "API"
  }

  vpc_config {
    subnet_ids              = concat(module.vpc.public_subnets, module.vpc.private_subnets)
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
  }

  compute_config {
    enabled       = true
    node_pools    = ["general-purpose"]
    node_role_arn = aws_iam_role.node.arn
  }

  kubernetes_network_config {
    elastic_load_balancing {
      enabled = true
    }
  }

  storage_config {
    block_storage {
      enabled = true
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster,
    aws_iam_role_policy_attachment.node
  ]
}
