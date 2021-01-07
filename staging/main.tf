data "aws_caller_identity" "current" {}
locals {
  map_users = [for user in module.user.new_developer_power_users : {
    userarn  = user.arn
    username = user.name
    groups   = ["system:masters"]
  }]

  # to get your current aws auth in your local
  # map_local_users = {
  #   userarn  = data.aws_caller_identity.current.arn
  #   username = data.aws_caller_identity.current.account_id
  #   groups   = ["system:masters"]
  # }

}

module "user" {
  source                = "../modules/user"
  developer_power_users = var.developer_power_users
  administrators        = var.administrators
  billings              = var.billings
}

module "network" {
  source          = "../modules/network"
  name            = var.name
  cidr            = var.cidr
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  cluster_name    = var.cluster_name
}

module "k8s" {
  source       = "../modules/k8s"
  cluster_name = var.cluster_name
  subnets      = module.network.private_subnets
  vpc_id       = module.network.vpc_id
  # map_roles    = []
  map_users        = local.map_users
  map_accounts     = module.user.new_developer_power_users_account_ids
  depends_on       = [module.network]
  create_eks       = var.create_eks
  grafana_user     = var.grafana_user
  grafana_password = var.grafana_password
}

module "db" {
  source                 = "../modules/db"
  database_name          = var.database_name
  database_user          = var.database_user
  database_password      = var.database_password
  database_port          = var.database_port
  subnet_ids             = module.network.private_subnets
  vpc_security_group_ids = [module.k8s.cluster_security_group_id]
  depends_on             = [module.network, module.k8s]
}
