output "rafay_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.rafay_s3_bucket.bucket
}
