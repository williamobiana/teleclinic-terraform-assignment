terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# create s3 bucket for the backend
resource "aws_s3_bucket" "state_file" {
  bucket = "teleclinic-assignment-state-file"
  force_destroy = true
}

# encrypt the bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_crypto_conf" {
  bucket = aws_s3_bucket.state_file.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

# create a dynamodb table for lockID
resource "aws_dynamodb_table" "terraform-lock" {
  name = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
     name = "LockID"
     type = "S"
  }
}