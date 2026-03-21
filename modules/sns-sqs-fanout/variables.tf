variable "topic_name" {
  description = "Name of the SNS topic"
  type        = string
  default     = "windmill-events"
}

variable "queue_name" {
  description = "Name of the SQS queue"
  type        = string
  default     = "windmill-processor"
}

variable "message_retention_seconds" {
  description = "Time in seconds that messages are retained in the queue"
  type        = number
  default     = 345600
}

variable "visibility_timeout_seconds" {
  description = "Visibility timeout for the queue in seconds"
  type        = number
  default     = 30
}

variable "max_receive_count" {
  description = "Maximum number of times a message can be received before being sent to DLQ"
  type        = number
  default     = 3
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# SNS Topic Variables
################################################################################

variable "fifo_topic" {
  description = "Boolean indicating whether or not to create a FIFO (first-in-first-out) topic"
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Boolean indicating whether or not to enable content-based deduplication for FIFO topics"
  type        = bool
  default     = false
}

variable "kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK"
  type        = string
  default     = null
}

variable "delivery_policy" {
  description = "The SNS delivery policy as JSON string"
  type        = string
  default     = null
}

variable "subscription_filter_policy" {
  description = "The filter policy JSON for the SNS subscription"
  type        = string
  default     = null
}

variable "subscription_filter_policy_scope" {
  description = "The filter policy scope for the SNS subscription. Valid values: MessageAttributes or MessageBody"
  type        = string
  default     = null
}

variable "raw_message_delivery" {
  description = "Boolean indicating whether to enable raw message delivery (no JSON wrapping)"
  type        = bool
  default     = true
}

################################################################################
# SQS Queue Variables
################################################################################

variable "fifo_queue" {
  description = "Boolean designating a FIFO queue"
  type        = bool
  default     = false
}

variable "queue_content_based_deduplication" {
  description = "Enables content-based deduplication for FIFO queues"
  type        = bool
  default     = null
}

variable "delay_seconds" {
  description = "The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes)"
  type        = number
  default     = null
}

variable "max_message_size" {
  description = "The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 1048576 bytes (1024 KiB)"
  type        = number
  default     = null
}

variable "receive_wait_time_seconds" {
  description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds)"
  type        = number
  default     = null
}

variable "sqs_managed_sse_enabled" {
  description = "Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys"
  type        = bool
  default     = true
}

variable "sqs_kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK"
  type        = string
  default     = null
}

variable "kms_data_key_reuse_period_seconds" {
  description = "The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again"
  type        = number
  default     = null
}

################################################################################
# Dead Letter Queue Variables
################################################################################

variable "dlq_message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message in the DLQ. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days)"
  type        = number
  default     = 1209600
}

variable "dlq_receive_wait_time_seconds" {
  description = "The time for which a ReceiveMessage call will wait for a message to arrive in the DLQ (long polling) before returning"
  type        = number
  default     = null
}

variable "dlq_visibility_timeout_seconds" {
  description = "The visibility timeout for the DLQ. An integer from 0 to 43200 (12 hours)"
  type        = number
  default     = null
}

variable "dlq_sqs_managed_sse_enabled" {
  description = "Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys for DLQ"
  type        = bool
  default     = true
}

variable "dlq_kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for the DLQ"
  type        = string
  default     = null
}
