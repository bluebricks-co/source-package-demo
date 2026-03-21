# eks-argocd

Terraform module that creates a fully self-contained EKS Auto Mode cluster with ArgoCD deployed as an EKS add-on.

This module uses community Terraform modules for best practices and maintainability:
- `terraform-aws-modules/vpc/aws` (~> 6.6.0) for VPC infrastructure
- `terraform-aws-modules/eks/aws` (~> 21.15.0) for EKS cluster with Auto Mode

## Resources Created

- VPC with public and private subnets across 2 availability zones
- Internet Gateway and NAT Gateway (single) for network connectivity
- EKS cluster in Auto Mode (compute, networking, and storage managed automatically)
- ArgoCD deployed as an EKS add-on

## Usage

```hcl
module "eks_argocd" {
  source = "./modules/eks-argocd"

  cluster_name          = "my-argocd-cluster"
  cluster_version       = "1.34"
  vpc_cidr              = "10.0.0.0/16"
  argocd_addon_version  = null  # Use latest version
  region                = "eu-central-1"

  tags = {
    Environment = "dev"
    Project     = "kubecon"
  }
}
```

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| cluster_name | Name of the EKS cluster | string | "tulip-argocd" |
| cluster_version | Kubernetes version for the EKS cluster | string | "1.34" |
| vpc_cidr | CIDR block for the VPC | string | "10.0.0.0/16" |
| argocd_addon_version | Version of the ArgoCD EKS add-on (null for latest) | string | null |
| region | AWS region for resources | string | "eu-central-1" |
| tags | Additional tags to apply to all resources | map(string) | {} |

## Outputs

| Name | Description |
|------|-------------|
| cluster_endpoint | Endpoint for the EKS cluster API server |
| argocd_addon_version | Installed version of the ArgoCD EKS add-on |
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
