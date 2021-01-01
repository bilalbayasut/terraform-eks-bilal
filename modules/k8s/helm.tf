# Create IAM OIDC provider
# Download IAM policy for the AWS Load Balancer Controller
# Create an IAM policy called AWSLoadBalancerControllerIAMPolicy
# Create a IAM role and ServiceAccount for the Load Balancer controller, use the ARN from the step above

resource "aws_iam_policy" "aws_load_balancer_controller_iam_policy" {
  name        = "AWSLoadBalancerControllerIAMPolicy"
  description = "policy for the ALB"
  policy      = file("${path.module}/policies/iam-policy.json")
}

output "aws_load_balancer_controller_iam_policy" {
  value = aws_iam_policy.aws_load_balancer_controller_iam_policy.arn
}
module "irsa" {
  source = "Young-ook/eks/aws//modules/iam-role-for-serviceaccount"

  namespace      = "kube-system"
  serviceaccount = "aws-load-balancer-controller"
  oidc_url       = module.eks.cluster_oidc_issuer_url
  oidc_arn       = module.eks.oidc_provider_arn
  policy_arns    = [aws_iam_policy.aws_load_balancer_controller_iam_policy.arn]
  tags           = { "env" = "staging" }
  enabled        = true
}

# resource "null_resource" "helm_add_eks_repo_charts" {
#   depends_on = [module.eks, null_resource.kubectl_update]
#   provisioner "local-exec" {
#     command = "helm repo add eks https://aws.github.io/eks-charts"
#   }
# }

# resource "null_resource" "k8s_apply_aws_load_balancer_controller" {
#   depends_on = [module.eks, null_resource.kubectl_update]
#   provisioner "local-exec" {
#     command = "kubectl apply -k 'github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master'"
#   }
# }

# resource "null_resource" "helm_install_aws_load_balancer_controller" {
#   depends_on = [module.eks, null_resource.k8s_apply_aws_load_balancer_controller]
#   provisioner "local-exec" {
#     # command = "helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=$NAME --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller"
#     command = "helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=$NAME"
#     environment = {
#       NAME = var.cluster_name
#     }
#   }
# }



# data "aws_eks_cluster" "cluster" {
#   name = module.eks.cluster_id
# }
# ### OIDC config
# resource "aws_iam_openid_connect_provider" "cluster" {
#   client_id_list  = ["sts.amazonaws.com"]
#   thumbprint_list = []
#   url             = data.aws_eks_cluster.cluster.identity.0.oidc.0.issuer
# }
# resource "aws_iam_policy" "aws_load_balancer_controller_iam_policy" {
#   name        = "AWSLoadBalancerControllerIAMPolicy"
#   description = "policy for the ALB"

#   policy = file("${path.module}/policies/iam-policy.json")
# }

# resource "null_resource" "policy_for_load_balancer" {
#   depends_on = [module.eks]
#   #   triggers = {
#   #     "always_run" = timestamp()
#   #   }
#   provisioner "local-exec" {
#     command = "aws eks update-kubeconfig --name $NAME --region $AWS_REGION"
#     environment = {
#       AWS_REGION = "us-east-1"
#       NAME       = var.cluster_name
#     }
#   }
# }

# # need to apply: kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master"
# resource "helm_release" "ingress" {
#   name       = "aws-load-balancer-controller"
#   chart      = "eks/aws-load-balancer-controller"
#   repository = "https://aws.github.io/eks-charts"
#   verify     = false
#   #   version    = "1.1.1"

#   set {
#     name  = "autoDiscoverAwsRegion"
#     value = "true"
#   }
#   set {
#     name  = "autoDiscoverAwsVpcID"
#     value = "true"
#   }
#   set {
#     name  = "clusterName"
#     value = var.cluster_name
#   }
# }

