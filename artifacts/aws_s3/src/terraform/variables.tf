variable "name" {
  description = "The name of the bucket"
  type        = string
}

variable "region" {
  type = string
  default = "eu-west-1"
}

variable "tags" {
  default =  {
    Environment = "demo"
  }
  description = "A mapping of tags to assign to the bucket."
  type = map(string)
}
