terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  # backend "s3" {
  #   bucket = "<your-s3-bucket-name>"
  #   key    = "<your-state-file-key>"
  #   region = "us-west-2"
  # }
  
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
  default_tags {
    tags = {
      New = "tag"
    }
  }
}
