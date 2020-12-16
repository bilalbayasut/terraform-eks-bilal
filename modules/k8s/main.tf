module "eks" {
  source                          = "terraform-aws-modules/eks/aws"
  version                         = "13.2.1"
  cluster_name                    = var.cluster_name
  cluster_version                 = "1.18"
  subnets                         = var.subnets
  cluster_endpoint_private_access = true

  vpc_id = var.vpc_id

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      additional_userdata           = ""
      asg_desired_capacity          = 1
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    },
    {
      name                          = "worker-group-2"
      instance_type                 = "t2.small"
      additional_userdata           = ""
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
      asg_desired_capacity          = 1
    },
  ]

  worker_additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  map_roles                            = var.map_roles
  map_users                            = var.map_users
  map_accounts                         = var.map_accounts



  write_kubeconfig   = true
  config_output_path = "./"
}
