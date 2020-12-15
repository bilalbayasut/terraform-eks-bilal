terraform {
    required_version = ">=0.1.4.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    local = {
        version = "~> 1.2"
    }
    random = {
        version = "~> 2.1"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}