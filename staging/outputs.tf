output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.network.vpc_id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.network.private_subnets
}
