output "topic_arn" {
  description = "ARN of the SNS topic"
  value       = module.sns.topic_arn
}

output "queue_url" {
  description = "URL of the SQS queue"
  value       = module.sqs.queue_url
}

output "queue_arn" {
  description = "ARN of the SQS queue"
  value       = module.sqs.queue_arn
}

output "dlq_url" {
  description = "URL of the dead letter queue"
  value       = module.dlq.queue_url
}

output "dlq_arn" {
  description = "ARN of the dead letter queue"
  value       = module.dlq.queue_arn
}
