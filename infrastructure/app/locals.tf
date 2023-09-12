locals {
  s3_bucket_policy = {
    Version = "2012-10-17"
    Statement = [
        {
            Sid = "IPAllowPolicy"
            Effect = "Deny"
            Principal = "*"
            Action = ["s3:GetObject", "s3:ListBucket"]
            Resource = ["${aws_s3_bucket.website_bucket.arn}", "${aws_s3_bucket.website_bucket.arn}/*"]

            Condition = {
                NotIpAddress = {
                    "aws:SourceIp" = ["18.158.69.72", "127.0.0.1"]
                }
            }
        }
    ]
  }
}