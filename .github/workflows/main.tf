terraform { 
  required_providers { 
    aws = { 
      source = "hashicorp/aws"
       version = "4.12.1"
     } 
  } 
} 

# Configure o
 provedor AWS Provider "aws" { 
  region = "ap-south-1"  # defina  a região de acordo com sua conta
 } 

resource "aws_s3_bucket"  "new_bucket" { 
  bucket = "demo-github-action-tf-medium4"

   object_lock_enabled = false

   tags = { 
    Environment = "Prod"
   } 
}