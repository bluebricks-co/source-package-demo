# sns-sqs-fanout

SNS topic with SQS queue(s) and DLQ. Demonstrates event-driven patterns.

## Resources

This module uses the following community modules:
- `terraform-aws-modules/sns/aws` (~> 7.1.0) for SNS topic
- `terraform-aws-modules/sqs/aws` (~> 5.2.0) for SQS queues (main + DLQ)

Resources created:
- SNS topic
- SQS queue (main)
- SQS queue (dead letter queue)
- SNS to SQS subscription
- SQS queue policy (allows SNS to send messages)

## Usage

```hcl
module "sns_sqs_fanout" {
  source = "./modules/sns-sqs-fanout"

  topic_name                 = "kubecon-demo-events"
  queue_name                 = "kubecon-demo-processor"
  message_retention_seconds  = 345600
  visibility_timeout_seconds = 30
  max_receive_count          = 3
  region                     = "eu-central-1"

  # Optional SNS settings
  fifo_topic                  = false
  content_based_deduplication = false
  kms_master_key_id           = null
  delivery_policy             = null

  # Optional SQS settings
  fifo_queue                        = false
  delay_seconds                     = null
  max_message_size                  = null
  receive_wait_time_seconds         = null
  sqs_managed_sse_enabled           = true

  tags = {
    Environment = "demo"
    Project     = "kubecon"
  }
}
```

## Inputs

### Core Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| topic_name | Name of the SNS topic | string | "windmill-events" |
| queue_name | Name of the SQS queue | string | "windmill-processor" |
| message_retention_seconds | Time in seconds that messages are retained in the queue | number | 345600 |
| visibility_timeout_seconds | Visibility timeout for the queue in seconds | number | 30 |
| max_receive_count | Maximum number of times a message can be received before being sent to DLQ | number | 3 |
| region | AWS region | string | "eu-central-1" |
| tags | Tags to apply to all resources | map(string) | {} |

### SNS Topic Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| fifo_topic | Boolean indicating whether or not to create a FIFO (first-in-first-out) topic | bool | false |
| content_based_deduplication | Boolean indicating whether or not to enable content-based deduplication for FIFO topics | bool | false |
| kms_master_key_id | The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK | string | null |
| delivery_policy | The SNS delivery policy as JSON string | string | null |
| subscription_filter_policy | The filter policy JSON for the SNS subscription | string | null |
| subscription_filter_policy_scope | The filter policy scope for the SNS subscription. Valid values: MessageAttributes or MessageBody | string | null |
| raw_message_delivery | Boolean indicating whether to enable raw message delivery (no JSON wrapping) | bool | true |

### SQS Queue Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| fifo_queue | Boolean designating a FIFO queue | bool | false |
| queue_content_based_deduplication | Enables content-based deduplication for FIFO queues | bool | null |
| delay_seconds | The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes) | number | null |
| max_message_size | The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 1048576 bytes (1024 KiB) | number | null |
| receive_wait_time_seconds | The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds) | number | null |
| sqs_managed_sse_enabled | Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys | bool | true |
| sqs_kms_master_key_id | The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK | string | null |
| kms_data_key_reuse_period_seconds | The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again | number | null |

### Dead Letter Queue Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| dlq_message_retention_seconds | The number of seconds Amazon SQS retains a message in the DLQ. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days) | number | 1209600 |
| dlq_receive_wait_time_seconds | The time for which a ReceiveMessage call will wait for a message to arrive in the DLQ (long polling) before returning | number | null |
| dlq_visibility_timeout_seconds | The visibility timeout for the DLQ. An integer from 0 to 43200 (12 hours) | number | null |
| dlq_sqs_managed_sse_enabled | Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys for DLQ | bool | true |
| dlq_kms_master_key_id | The ID of an AWS-managed customer master key (CMK) for the DLQ | string | null |

## Outputs

### SNS Topic Outputs

| Name | Description |
|------|-------------|
| topic_arn | ARN of the SNS topic |
| topic_id | The ARN of the SNS topic |
| topic_name | The name of the topic |
| topic_owner | The AWS Account ID of the SNS topic owner |
| subscriptions | Map of subscriptions created and their attributes |

### SQS Queue Outputs

| Name | Description |
|------|-------------|
| queue_url | URL of the SQS queue |
| queue_arn | ARN of the SQS queue |
| queue_id | The URL for the created Amazon SQS queue |
| queue_name | The name of the SQS queue |

### Dead Letter Queue Outputs

| Name | Description |
|------|-------------|
| dlq_url | URL of the dead letter queue |
| dlq_arn | ARN of the dead letter queue |
| dlq_id | The URL for the created dead letter queue |
| dlq_name | The name of the dead letter queue |
