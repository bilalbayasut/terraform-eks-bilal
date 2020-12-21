# output "vpc_id" {
#   description = "The ID of the VPC"
#   value       = module.network.vpc_id
# }

# output "private_subnets" {
#   description = "List of IDs of private subnets"
#   value       = module.network.private_subnets
# }

# output "kubectl_config" {
#   description = "kubectl config as generated by the module."
#   value       = module.k8s.kubeconfig
# }

output "users" {
  description = "users"
  value       = module.user
}

output "new_developer_power_users_arn" {
  value = module.user.new_developer_power_users_arn
}

# user_id
output "new_developer_power_users_user_id" {
  value = module.user.new_developer_power_users_user_id
}

# user_name
output "new_developer_power_users_name" {
  value = module.user.new_developer_power_users_name
}

# password
output "new_developer_power_users_password" {
  value = module.user.new_developer_power_users_password[0]
}

# secret key
output "new_developer_power_users_secret" {
  value = module.user.new_developer_power_users_secret
}
