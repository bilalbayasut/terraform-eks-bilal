
module "user" {
  source                = "../modules/user"
  developer_power_users = var.developer_power_users
  administrators        = var.administrators
  billings              = var.billings
}

# module "network" {
#   source          = "../modules/network"
#   name            = var.name
#   cidr            = var.cidr
#   azs             = var.azs
#   public_subnets  = var.public_subnets
#   private_subnets = var.private_subnets
#   cluster_name = var.cluster_name
# }

# module "k8s" {
#   source       = "../modules/k8s"
#   cluster_name = var.cluster_name
#   subnets      = module.network.private_subnets
#   vpc_id       = module.network.vpc_id
#   map_roles    = []
#   map_users    = var.map_users
#   map_accounts = module.user.new_developer_power_users_account_ids
#   depends_on = [module.network]
# }
