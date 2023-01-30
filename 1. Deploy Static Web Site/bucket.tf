resource "aws_s3_bucket" "www-bucket" {
  bucket = var.bucket_name
  tags = {
    Name = "www-bucket"
  }
}

resource "aws_s3_bucket_acl" "www-bucket-acl" {
  bucket = var.bucket_name
  acl = "private"
}

resource "aws_s3_bucket_versioning" "www-bucket_versioning" {
  bucket = var.bucket_name
  versioning_configuration {
    status = "Enabled"
  }
}