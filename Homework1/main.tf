terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

# configure provider
provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_key
  secret_key = var.aws_secret
}


