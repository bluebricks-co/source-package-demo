
output "bucket_names" {
  value = [for bucket in module.s3 : bucket.s3_bucket_id]
}


