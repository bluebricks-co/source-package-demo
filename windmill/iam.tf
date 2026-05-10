module "windmill_pod_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "~> 6.4.0"

  name        = "windmill-pod-role"
  description = "IAM role for windmill-processor EKS Pod Identity"

  trust_policy_permissions = {
    PodIdentity = {
      actions = ["sts:AssumeRole", "sts:TagSession"]
      principals = [{
        type        = "Service"
        identifiers = ["pods.eks.amazonaws.com"]
      }]
    }
  }

  inline_policy_permissions = {
    sqs_windmill_processor = {
      actions = [
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes",
      ]
      resources = [
        "arn:aws:sqs:eu-central-1:381491880156:windmill-processor",
      ]
    }
  }
}
