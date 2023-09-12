#Initialize the backend
terraform {
  backend "s3" {
    bucket = "teleclinic-assignment-state-file"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt = true
  }
}