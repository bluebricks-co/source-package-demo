# infra-live

Infrastructure-as-Code repository managed with [Bluebricks](https://bluebricks.co) and OpenTofu/Terraform.

## Modules

| Module | Description |
|--------|-------------|
| `vpc-network` | VPC with public/private subnets, NAT gateway, flow logs |
| `eks-argocd` | EKS Auto Mode cluster with ArgoCD capability |
| `eks-automode` | Standalone EKS Auto Mode cluster |
| `ecr-registry` | ECR repository with lifecycle policies and scanning |
| `s3-state-backend` | S3 + DynamoDB for Terraform state locking |
| `sns-sqs-fanout` | SNS topic with SQS queue and DLQ |
| `iam-pod-identity` | IAM role for EKS Pod Identity |

## Usage

Each module is a self-contained root module with its own provider configuration. All variables have defaults -- modules work out of the box with no tfvars.

```bash
cd modules/<module-name>
terraform init
terraform plan
terraform apply
```

## Prerequisites

- Terraform/OpenTofu >= 1.0
- AWS credentials configured
- Bluebricks CLI (`bricks login`) for environment management
