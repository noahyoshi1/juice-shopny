provider "aws" {
  region = "us-east-1"
} resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-name"
  acl    = "private"   server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }   server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
        kms_master_key_id = null
      }
    }
  }   versioning {
    enabled = true
  }   lifecycle {
    ignore_changes = [
      server_side_encryption_configuration,
      versioning
    ]
  }
} output "s3_bucket_name" {
  value = aws_s3_bucket.my_bucket.id
}
