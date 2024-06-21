# Configure Terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.52.0"
    }
  }
}
 
# Configure AWS Provider
provider "aws" {
  region = "us-east-1" # Update with your desired region
}
resource "aws_s3_bucket" "softteek" {
  bucket = "softteek"
}

resource "aws_s3_bucket_public_access_block" "softteek" {
  bucket = aws_s3_bucket.softteek.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}