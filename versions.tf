terraform {
  required_version = ">= 0.13.5"
}

provider "aws" {
  version = ">= 3.20.0"
  region  = var.region
}

provider "random" {
  version = "~> 2.3.1"
}

provider "local" {
  version = "~> 1.4.0"
}

provider "null" {
  version = "~> 2.1.2"
}

