variable "aws_region" {
  description = "The AWS region where the S3 bucket will be created."
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket."
  default     = "teleclinic-app-bucket-assignment"
}

variable "local_index_path" {
  description = "The local path to the 'index.html' file."
  default     = "/home/william/workspace/repo/teleclinic-terraform-index/infrastructure/app/index.html"
}