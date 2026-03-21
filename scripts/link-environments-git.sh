#!/usr/bin/env bash
set -euo pipefail

# Link Git repos to already-created Bluebricks environments.
# Actual API fields: environment_slug, git_remote_url, git_base_branch

API_URL="https://api.bricks-dev.com"
REPO_URL="git@github.com:bluebricks-co/infra-live.git"
BRANCH="main"

TOKEN=$(grep '^token:' "$HOME/.bricks/credentials.yaml" | sed 's/^token: //')

# slug|subfolder
ENVS=(
  "dam-network|modules/vpc-network"
  "dam-tf-state|modules/s3-state-backend"
  "tulip-cluster|modules/eks-automode"
  "tulip-argocd|modules/eks-argocd"
  "tulip-app|modules/ecr-registry"
  "windmill-events|modules/sns-sqs-fanout"
  "windmill-pod-role|modules/iam-pod-identity"
)

echo "Linking Git to ${#ENVS[@]} environments..."
echo ""

for entry in "${ENVS[@]}"; do
  IFS='|' read -r slug subfolder <<< "$entry"

  echo "--- $slug ---"

  RESPONSE=$(curl -s -w "\n%{http_code}" \
    -X POST "$API_URL/api/v1/env/git" \
    -H "Authorization: $TOKEN" \
    -H "Content-Type: application/json" \
    -d "{\"environment_slug\": \"$slug\", \"git_remote_url\": \"$REPO_URL//$subfolder\", \"git_base_branch\": \"$BRANCH\"}")

  HTTP_CODE=$(echo "$RESPONSE" | tail -1)
  BODY=$(echo "$RESPONSE" | sed '$d')

  if [[ "$HTTP_CODE" != "200" && "$HTTP_CODE" != "201" ]]; then
    echo "  FAILED (HTTP $HTTP_CODE): $BODY"
  else
    echo "  Linked: $REPO_URL//$subfolder"
  fi
  echo ""
done

echo "Done."
