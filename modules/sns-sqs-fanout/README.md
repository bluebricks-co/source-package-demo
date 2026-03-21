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
  region                     = "eu-west-1"
  tags = {
    Environment = "demo"
    Project     = "kubecon"
  }
}
```

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| topic_name | Name of the SNS topic | string | "kubecon-demo-events" |
| queue_name | Name of the SQS queue | string | "kubecon-demo-processor" |
| message_retention_seconds | Time in seconds that messages are retained in the queue | number | 345600 |
| visibility_timeout_seconds | Visibility timeout for the queue in seconds | number | 30 |
| max_receive_count | Maximum number of times a message can be received before being sent to DLQ | number | 3 |
| region | AWS region | string | "eu-west-1" |
| tags | Tags to apply to all resources | map(string) | {} |

## Outputs

| Name | Description |
|------|-------------|
| topic_arn | ARN of the SNS topic |
| queue_url | URL of the SQS queue |
| queue_arn | ARN of the SQS queue |
| dlq_url | URL of the dead letter queue |
| dlq_arn | ARN of the dead letter queue |
