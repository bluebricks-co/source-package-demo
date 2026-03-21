# iam-pod-identity

Terraform module for creating an IAM role configured for EKS Pod Identity trust. This module creates a standalone IAM role that can be used with EKS Pod Identity without requiring an existing cluster.

## Features

- IAM role with trust policy for `pods.eks.amazonaws.com`
- Attach multiple AWS managed policies
- Optional custom inline policy
- Standalone - does not require an existing EKS cluster

## Usage

```hcl
module "pod_identity_role" {
  source = "./modules/iam-pod-identity"

  role_name   = "my-app-pod-role"
  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess"
  ]

  tags = {
    Environment = "production"
    Application = "my-app"
  }
}
```

### With Custom Policy

```hcl
module "pod_identity_role" {
  source = "./modules/iam-pod-identity"

  role_name = "custom-app-pod-role"

  custom_policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::my-bucket",
          "arn:aws:s3:::my-bucket/*"
        ]
      }
    ]
  })
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| role_name | Name of the IAM role for EKS Pod Identity | `string` | `"windmill-pod-role"` | no |
| use_name_prefix | Determines whether the IAM role name is used as a prefix | `bool` | `false` | no |
| path | Path of IAM role | `string` | `null` | no |
| description | Description of the IAM role | `string` | `null` | no |
| max_session_duration | Maximum session duration (in seconds) for the role. Valid values: 3600 to 43200 | `number` | `null` | no |
| permissions_boundary_arn | ARN of the policy that is used to set the permissions boundary for the IAM role | `string` | `null` | no |
| policy_arns | List of IAM policy ARNs to attach to the role | `list(string)` | `["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]` | no |
| custom_policy_json | Custom IAM policy JSON document to attach to the role | `string` | `null` | no |
| inline_policy_statements | Map of inline policy statements to add to the IAM role | `map(object)` | `{}` | no |
| trust_policy_conditions | Additional condition constraints for the trust policy | `list(object)` | `[]` | no |
| region | AWS region where resources will be created | `string` | `"eu-central-1"` | no |
| tags | Tags to apply to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| role_arn | ARN of the IAM role for EKS Pod Identity |
| role_name | Name of the IAM role for EKS Pod Identity |
| role_unique_id | Stable and unique string identifying the IAM role |
| custom_policy_arn | ARN of the custom IAM policy (if created) |
| custom_policy_id | ID of the custom IAM policy (if created) |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 5.70.0 |
