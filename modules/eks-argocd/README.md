# eks-argocd

Terraform module that creates a fully self-contained EKS cluster with ArgoCD deployed as an EKS add-on.

This module uses community Terraform modules for best practices and maintainability:
- `terraform-aws-modules/vpc/aws` (~> 6.6.0) for VPC infrastructure
- `terraform-aws-modules/eks/aws` (~> 21.15.0) for EKS cluster and node groups

## Resources Created

- VPC with public and private subnets across 2 availability zones
- Internet Gateway and NAT Gateway (single) for network connectivity
- EKS cluster in standard mode (not auto mode)
- EKS managed node group with configurable instance type and size
- ArgoCD deployed as an EKS add-on

## Usage

```hcl
module "eks_argocd" {
  source = "./modules/eks-argocd"

  cluster_name          = "my-argocd-cluster"
  cluster_version       = "1.31"
  vpc_cidr              = "10.0.0.0/16"
  argocd_addon_version  = null  # Use latest version
  node_instance_type    = "t3.medium"
  node_desired_size     = 2
  region                = "eu-west-1"

  tags = {
    Environment = "dev"
    Project     = "kubecon"
  }
}
```

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| cluster_name | Name of the EKS cluster | string | "kubecon-argocd" |
| cluster_version | Kubernetes version for the EKS cluster | string | "1.34" |
| vpc_cidr | CIDR block for the VPC | string | "10.0.0.0/16" |
| argocd_addon_version | Version of the ArgoCD EKS add-on (null for latest) | string | null |
| node_instance_type | EC2 instance type for EKS worker nodes | string | "t3.medium" |
| node_desired_size | Desired number of worker nodes | number | 2 |
| region | AWS region for resources | string | "eu-west-1" |
| tags | Additional tags to apply to all resources | map(string) | {} |

## Outputs

| Name | Description |
|------|-------------|
| cluster_endpoint | Endpoint for the EKS cluster API server |
| argocd_addon_status | Status of the ArgoCD EKS add-on |
| kubeconfig_command | Command to configure kubectl for this cluster |

## Post-Deployment

After deployment, configure kubectl to access the cluster:

```bash
aws eks update-kubeconfig --name <cluster_name> --region <region>
```

Access ArgoCD UI:

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Get the initial admin password:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```
