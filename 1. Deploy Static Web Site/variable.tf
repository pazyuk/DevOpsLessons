variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "region" {
  default = "us-east-1"
}

variable "bucket_name" {
  default = "www-bucket"
}

variable "ansible_user" {
  default = "ubuntu"
}

variable "dns-zone" {
  default = "sample.com"
}

variable "private_key" {
  default = "~/.ssh/id_rsa"
}