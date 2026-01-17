# Source Package Demo

A demonstration repository showcasing BlueBricks infrastructure deployment with AWS S3 bucket provisioning using Terraform.

## Overview

This repository contains a BlueBricks source package that deploys an AWS S3 bucket in a specific region.

## Repository Structure

```
├── .github/workflows/          # CI/CD workflows
│   ├── apply.yaml             # Production deployment workflow
│   └── plan.yaml              # Pull request planning workflow
├── artifacts/aws_s3/          # Source package artifacts
│   └── src/terraform/         # Terraform infrastructure code
├── deployments/               # BlueBricks deployment configurations
│   └── s3-bucket.yaml        # S3 bucket deployment spec
└── .gitignore
```

## Workflows

### Plan Workflow (`.github/workflows/plan.yaml`)
- **Trigger**: Pull requests
- **Purpose**: Creates deployment plans for review
- **Actions**: 
  - Checks out code
  - Runs BlueBricks plan-only mode using `bluebricks-co/bricks-action@v1`
  - Uses deployment spec from `deployments/s3-bucket.yaml`

### Apply Workflow (`.github/workflows/apply.yaml`)
- **Trigger**: Push to `main` branch
- **Purpose**: Deploys infrastructure changes
- **Actions**:
  - Checks out code
  - Executes BlueBricks deployment using `bluebricks-co/bricks-action@v1`
  - Applies changes defined in `deployments/s3-bucket.yaml`

## Deployment Configuration

The deployment is configured in `deployments/s3-bucket.yaml`:

```yaml
apiVersion: bricks/v1
kind: Deployment
metadata:
  name: source-package-demo-s3
spec:
  blueprint: source_package_demo_aws_s3
  version: 1.1.0
  environment: source-package-demo
  props:
    name: bluebricks-source-package-demo-s3
    region: eu-west-1
```

## Prerequisites

- BlueBricks API key configured as `BRICKS_API_KEY` secret
- AWS credentials configured in BlueBricks environment
- Terraform >= 1.0

## Usage

1. **Development**: Create pull requests to trigger planning workflow
2. **Deployment**: Merge to `main` branch to trigger apply workflow
3. **Configuration**: Modify `deployments/s3-bucket.yaml` to adjust deployment parameters

## Variables

Key configurable variables include:
- `name`: S3 bucket name
- `region`: AWS region
