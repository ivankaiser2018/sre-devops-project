terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.12.1"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # define region as per your account
}

resource "aws_s3_bucket" "new_bucket" {
  bucket = "bucket-valid-teste3"

  object_lock_enabled = false

  tags = {
    Environment = "Prod"
  }
}

#...
resource "aws_instance" "ec2_instance" {
  ami           = "ami-06e46074ae430fba6" # Substitua pela AMI desejada
  instance_type = "t2.micro"
  key_name      = "key2023" # Substitua pelo nome da sua chave SSH
}




