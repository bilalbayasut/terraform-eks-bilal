variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  # default     = "my-cluster"
}

variable "create_eks" {
  description = "conditional bool for eks creation"
  type        = bool
}

variable "vpc_id" {
  description = "ID of the VPC in which security resources are deployed"
  type        = string
}

variable "grafana_user" {
  description = "username for grafana dashboard"
  type        = string
}

variable "grafana_password" {
  description = "password for grafana password"
  type        = string
}

variable "subnets" {
  description = "PVC subnets"
  type        = list(string)
}

variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list(string)

  default = [
    "777777777777",
    "888888888888",
  ]
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
