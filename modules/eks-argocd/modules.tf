module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.6.0"

  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr

  azs             = ["${var.region}a", "${var.region}b"]
  public_subnets  = var.public_subnet_cidrs
  private_subnets = var.private_subnet_cidrs

  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = var.single_nat_gateway
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.15.0"

  name              = var.cluster_name
  kubernetes_version = var.cluster_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  endpoint_public_access = var.endpoint_public_access

  create_kms_key    = false
  encryption_config = null

  compute_config = {
    enabled    = true
    node_pools = var.node_pools
  }
}

module "argocd" {
  source = "terraform-aws-modules/eks/aws//modules/capability"
  version = "~> 21.15.0"

  type         = "ARGOCD"
  cluster_name = module.eks.cluster_name

  configuration = {
    argo_cd = {
      aws_idc = {
        idc_instance_arn = var.idc_instance_arn
      }
      namespace = var.argocd_namespace
    }
  }

  tags = var.tags

  depends_on = [module.eks]
}
