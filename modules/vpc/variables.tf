# variable "cluster_name" {
#   description = "EKS cluster name"
#   type        = "string"
#   default     = "my-cluster"
# }

## AWS
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

## VPC
variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
  default     = "0.0.0.0/0"
}

variable "azs" {
  description = "A list of availability zones in the region"
  type        = list(any)
  default     = []
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(any)
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(any)
  default     = []
}
