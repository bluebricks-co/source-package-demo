module "dlq" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "~> 5.2.0"

  name = "${var.queue_name}-dlq"
}

module "sqs" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "~> 5.2.0"

  name                       = var.queue_name
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds

  redrive_policy = {
    deadLetterTargetArn = module.dlq.queue_arn
    maxReceiveCount     = var.max_receive_count
  }

  create_queue_policy = true
  queue_policy_statements = {
    sns = {
      sid    = "AllowSNSToSendMessages"
      effect = "Allow"

      principals = [
        {
          type        = "Service"
          identifiers = ["sns.amazonaws.com"]
        }
      ]

      actions = [
        "sqs:SendMessage"
      ]

      conditions = [
        {
          test     = "ArnEquals"
          variable = "aws:SourceArn"
          values   = [module.sns.topic_arn]
        }
      ]
    }
  }
}

module "sns" {
  source  = "terraform-aws-modules/sns/aws"
  version = "~> 7.1.0"

  name = var.topic_name

  subscriptions = {
    sqs = {
      protocol             = "sqs"
      endpoint             = module.sqs.queue_arn
      raw_message_delivery = true
    }
  }
}
