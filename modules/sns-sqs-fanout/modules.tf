module "dlq" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "~> 5.2.0"

  name                       = "${var.queue_name}-dlq"
  message_retention_seconds  = var.dlq_message_retention_seconds
  receive_wait_time_seconds  = var.dlq_receive_wait_time_seconds
  visibility_timeout_seconds = var.dlq_visibility_timeout_seconds
  sqs_managed_sse_enabled    = var.dlq_sqs_managed_sse_enabled
  kms_master_key_id          = var.dlq_kms_master_key_id
}

module "sqs" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "~> 5.2.0"

  name                              = var.queue_name
  fifo_queue                        = var.fifo_queue
  content_based_deduplication       = var.queue_content_based_deduplication
  visibility_timeout_seconds        = var.visibility_timeout_seconds
  message_retention_seconds         = var.message_retention_seconds
  delay_seconds                     = var.delay_seconds
  max_message_size                  = var.max_message_size
  receive_wait_time_seconds         = var.receive_wait_time_seconds
  sqs_managed_sse_enabled           = var.sqs_managed_sse_enabled
  kms_master_key_id                 = var.sqs_kms_master_key_id
  kms_data_key_reuse_period_seconds = var.kms_data_key_reuse_period_seconds

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

  name                        = var.topic_name
  fifo_topic                  = var.fifo_topic
  content_based_deduplication = var.content_based_deduplication
  kms_master_key_id           = var.kms_master_key_id
  delivery_policy             = var.delivery_policy

  subscriptions = {
    sqs = {
      protocol               = "sqs"
      endpoint               = module.sqs.queue_arn
      raw_message_delivery   = var.raw_message_delivery
      filter_policy          = var.subscription_filter_policy
      filter_policy_scope    = var.subscription_filter_policy_scope
    }
  }
}
