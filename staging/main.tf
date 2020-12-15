module "vpc" {
  source          = "../modules/vpc"
  name            = var.name
  cidr            = var.cidr
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "eks" {
  source       = "../modules/eks"
  cluster_name = var.cluster_name
  subnets      = var.private_subnets
  vpc_id       = module.vpc.vpc_id
  map_roles    = var.map_roles
  map_users    = var.map_users
  map_accounts = var.map_accounts
}
