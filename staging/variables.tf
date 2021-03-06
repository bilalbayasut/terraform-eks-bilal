variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "create_eks" {
  description = "conditional bool for eks creation"
  type        = bool
}

# grafana
variable "grafana_user" {
  description = "username for grafana dashboard"
  type        = string
}

variable "grafana_password" {
  description = "password for grafana password"
  type        = string
}

# DB
variable "database_name" {
  description = "database_name"
  type        = string
}

variable "database_user" {
  description = "database user"
  type        = string
}
variable "database_password" {
  description = "database_password"
  type        = string
}
variable "database_port" {
  description = "database_port"
  type        = string
}

## AWS
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
variable "developer_power_users" {
  type    = list(string)
  default = []
}

variable "administrators" {
  type    = list(string)
  default = []
}

variable "billings" {
  type    = list(string)
  default = []
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

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      rolearn  = "arn:aws:iam::66666666666:role/role1"
      username = "role1"
      groups   = ["system:masters"]
    },
  ]
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn:aws:iam::66666666666:user/user1"
      username = "user1"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::66666666666:user/user2"
      username = "user2"
      groups   = ["system:masters"]
    },
  ]
}
