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
  default     = "eu-west-1"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
