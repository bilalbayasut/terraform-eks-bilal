module "eks" {
  source                          = "terraform-aws-modules/eks/aws"
  version                         = "13.2.1"
  cluster_name                    = var.cluster_name
  cluster_version                 = "1.19.3"
  subnets                         = var.subnets
  cluster_endpoint_private_access = true
  # create_eks                      = var.create_eks
  create_eks = true
  vpc_id     = var.vpc_id

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
  workers_additional_policies          = [aws_iam_policy.worker_policy.arn]
  map_roles                            = var.map_roles
  map_users                            = var.map_users
  map_accounts                         = var.map_accounts
  write_kubeconfig                     = true
  config_output_path                   = "./"

}

resource "aws_iam_policy" "worker_policy" {
  name        = "worker-policy"
  description = "Worker policy for the ALB Ingress"

  policy = file("${path.module}/iam-policy.json")
}

resource "null_resource" "kubectl_update" {
  depends_on = [module.eks]
  triggers = {
    "always_run" = timestamp()
  }
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name $NAME --region $AWS_REGION"
    environment = {
      AWS_REGION = "us-east-1"
      NAME       = var.cluster_name
    }
  }
}

# NOTE: Failed
# module "eks-alb-ingress" {
#   source  = "lablabs/eks-alb-ingress/aws"
#   version = "0.4.1"
#   # insert the 5 required variables here
# }

# NOTE: Failed
# resource "aws_lb" "test" {
#   name               = "test-lb-tf"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.all_worker_mgmt.id]
#   # subnets            = concat(module.vpc.public_subnets.*.id, module.vpc.private_subnets.*.id)
#   subnets = var.subnets

#   enable_deletion_protection = true

#   # access_logs {
#   #   bucket  = aws_s3_bucket.lb_logs.bucket
#   #   prefix  = "test-lb"
#   #   enabled = true
#   # }

#   tags = {
#     Environment = "staging"
#   }
# }
