resource "aws_s3_bucket" "rafay_s3_bucket" {
  bucket = var.bucket_name

  # Minimal settings to reduce costs
  force_destroy = true # Automatically delete objects when deleting the bucket

  tags = var.tags
}

resource "aws_s3_bucket_lifecycle_configuration" "rafay_lifecycle_rule" {
  bucket = aws_s3_bucket.rafay_s3_bucket.id

  rule {
    id     = "ExpireObjects"
    status = "Enabled"

    expiration {
      days = 1 # Automatically delete objects after 1 day
    }
  }
}