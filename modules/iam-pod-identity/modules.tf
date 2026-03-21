module "iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "~> 6.4.0"

  name                 = var.role_name
  use_name_prefix      = var.use_name_prefix
  path                 = var.path
  description          = var.description
  max_session_duration = var.max_session_duration
  permissions_boundary = var.permissions_boundary_arn

  trust_policy_permissions = {
    PodIdentity = {
      actions = ["sts:AssumeRole", "sts:TagSession"]
      principals = [{
        type        = "Service"
        identifiers = ["pods.eks.amazonaws.com"]
      }]
    }
  }

  trust_policy_conditions = var.trust_policy_conditions

  policies = { for idx, arn in var.policy_arns : "policy-${idx}" => arn }

  create_inline_policy      = length(var.inline_policy_statements) > 0
  inline_policy_permissions = var.inline_policy_statements

  tags = var.tags
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
