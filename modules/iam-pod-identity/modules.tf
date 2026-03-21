module "iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "~> 6.4.0"

  name            = var.role_name
  use_name_prefix = false

  trust_policy_permissions = {
    pod_identity = {
      actions = ["sts:AssumeRole", "sts:TagSession"]
      principals = [{
        type        = "Service"
        identifiers = ["pods.eks.amazonaws.com"]
      }]
    }
  }

  policies = { for idx, arn in var.policy_arns : "policy-${idx}" => arn }
}

resource "aws_iam_policy" "custom" {
  count = var.custom_policy_json != null ? 1 : 0

  name   = "${var.role_name}-custom-policy"
  policy = var.custom_policy_json
}

resource "aws_iam_role_policy_attachment" "custom" {
  count = var.custom_policy_json != null ? 1 : 0

  role       = module.iam_role.name
  policy_arn = aws_iam_policy.custom[0].arn
}
