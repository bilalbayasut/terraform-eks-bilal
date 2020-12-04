terraform {
  required_version = ">= 0.13.5"
}

provider "aws" {
  version = ">= 2.28.1"
}

provider "random" {
  version = "~> 2.1"
}

provider "local" {
  version = "~> 1.2"
}

provider "null" {
  version = "~> 2.1"
}

provider "template" {
  version = "~> 2.1"
}