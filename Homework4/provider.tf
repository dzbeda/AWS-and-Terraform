variable "aws_region" {
  type = string
  description = "Describe the AWS working region"
}
terraform {
  required_version = ">= 0.14.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  backend "remote" {
    organization = "zbeda"
    workspaces {
      name = "aws"
    }
  }
}

# configure provider
provider "aws" {
  region     = var.aws_region
}

