################################################################################
# SNS Topic Outputs
################################################################################

output "topic_arn" {
  description = "ARN of the SNS topic"
  value       = module.sns.topic_arn
}

output "topic_id" {
  description = "The ARN of the SNS topic"
  value       = module.sns.topic_id
}

output "topic_name" {
  description = "The name of the topic"
  value       = module.sns.topic_name
}

output "topic_owner" {
  description = "The AWS Account ID of the SNS topic owner"
  value       = module.sns.topic_owner
}

output "subscriptions" {
  description = "Map of subscriptions created and their attributes"
  value       = module.sns.subscriptions
}

################################################################################
# SQS Queue Outputs
################################################################################

output "queue_url" {
  description = "URL of the SQS queue"
  value       = module.sqs.queue_url
}

output "queue_arn" {
  description = "ARN of the SQS queue"
  value       = module.sqs.queue_arn
}

output "queue_id" {
  description = "The URL for the created Amazon SQS queue"
  value       = module.sqs.queue_id
}

output "queue_name" {
  description = "The name of the SQS queue"
  value       = module.sqs.queue_name
}

################################################################################
# Dead Letter Queue Outputs
################################################################################

output "dlq_url" {
  description = "URL of the dead letter queue"
  value       = module.dlq.queue_url
}

output "dlq_arn" {
  description = "ARN of the dead letter queue"
  value       = module.dlq.queue_arn
}

output "dlq_id" {
  description = "The URL for the created dead letter queue"
  value       = module.dlq.queue_id
}

output "dlq_name" {
  description = "The name of the dead letter queue"
  value       = module.dlq.queue_name
}
