#select region
provider "aws" {
  region = var.aws_region
}

#create the website bucket
resource "aws_s3_bucket" "website_bucket" {
  bucket           = var.bucket_name
  force_destroy    = true

  website {
    index_document = "index.html"
  }
}

#make publicly accessible
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

#add ownership to make index.html public
resource "aws_s3_bucket_ownership_controls" "public_ownership" {
  bucket             = aws_s3_bucket.website_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

#copy index.html to s3
resource "aws_s3_bucket_object" "index" {
  bucket       = aws_s3_bucket.website_bucket.id
  key          = "index.html"
  acl          = "public-read"
  content_type = "text/html"

  source       = var.local_index_path
}

#create the policy to deny all IPs except "18.158.69.72 and localhost"
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.id

  policy = jsonencode(local.s3_bucket_policy)
}

output "website_domain" {
  value = aws_s3_bucket.website_bucket.website_endpoint
}