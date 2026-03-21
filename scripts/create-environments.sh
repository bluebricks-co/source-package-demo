#!/usr/bin/env bash
set -euo pipefail

# Create Bluebricks environments for all 7 KubeCon demo modules.
#
# Prerequisites:
#   bricks login   # populates ~/.bricks/credentials.yaml with JWT
#
# Usage:
#   ./scripts/create-environments.sh

# --- Config ---
API_URL="https://api.bricks-dev.com"
REPO_URL="git@github.com:bluebricks-co/infra-live.git"
BRANCH="main"
COLLECTION="workload-develop"
IAC_TYPE="opentofu"

# --- Read JWT from bricks credentials ---
CREDS_FILE="$HOME/.bricks/credentials.yaml"
if [[ ! -f "$CREDS_FILE" ]]; then
  echo "Error: $CREDS_FILE not found. Run 'bricks login' first."
  exit 1
fi

TOKEN=$(grep '^token:' "$CREDS_FILE" | sed 's/^token: //')
if [[ -z "$TOKEN" ]]; then
  echo "Error: No token found in $CREDS_FILE. Run 'bricks login' first."
  exit 1
fi

# --- Module definitions: slug|name|description|subfolder|package_name ---
MODULES=(
  "dam-network|Dam Network|VPC with public/private subnets, IGW, NAT Gateway|modules/vpc-network|vpc-network"
  "dam-tf-state|Dam TF State|S3 bucket and DynamoDB table for Terraform state locking|modules/s3-state-backend|s3-state-backend"
  "tulip-cluster|Tulip Cluster|EKS Auto Mode cluster with self-contained VPC and IAM|modules/eks-automode|eks-automode"
  "tulip-argocd|Tulip ArgoCD|EKS cluster with ArgoCD deployed as EKS add-on|modules/eks-argocd|eks-argocd"
  "tulip-app|Tulip App|ECR repository with lifecycle policies and image scanning|modules/ecr-registry|ecr-registry"
  "windmill-events|Windmill Events|SNS topic with SQS queue and DLQ for event-driven patterns|modules/sns-sqs-fanout|sns-sqs-fanout"
  "windmill-pod-role|Windmill Pod Role|IAM role configured for EKS Pod Identity trust|modules/iam-pod-identity|iam-pod-identity"
)

echo "Creating ${#MODULES[@]} Bluebricks environments..."
echo ""

for entry in "${MODULES[@]}"; do
  IFS='|' read -r slug name description subfolder package_name <<< "$entry"

  echo "--- $name ($slug) ---"

  RESPONSE=$(curl -s -w "\n%{http_code}" \
    -X POST "$API_URL/api/v1/env/git" \
    -H "Authorization: $TOKEN" \
    -H "Content-Type: application/json" \
    -d "$(cat <<EOF
{
  "environment_slug": "$slug",
  "git_remote_url": "$REPO_URL",
  "git_base_branch": "$BRANCH",
  "git_subdir_path": "$subfolder",
  "collection": "$COLLECTION",
  "iac_type": "$IAC_TYPE",
  "package_name": "$package_name",
  "package_description": "$description"
}
EOF
)")

  HTTP_CODE=$(echo "$RESPONSE" | tail -1)
  BODY=$(echo "$RESPONSE" | sed '$d')

  if [[ "$HTTP_CODE" != "200" && "$HTTP_CODE" != "201" ]]; then
    echo "  FAILED (HTTP $HTTP_CODE): $BODY"
  else
    echo "  Created: $slug -> $REPO_URL // $subfolder"
  fi
  echo ""
done

echo "Done."
