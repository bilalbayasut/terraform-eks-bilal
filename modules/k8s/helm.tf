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
  enabled        = false
}

# resource "null_resource" "helm_repo_update" {
#   depends_on = [module.eks, null_resource.kubectl_update]
#   provisioner "local-exec" {
#     command = "helm repo update"
#   }
# }
resource "null_resource" "helm_add_eks_repo_charts" {
  depends_on = [module.eks, null_resource.kubectl_update]
  provisioner "local-exec" {
    command = "helm repo update && helm repo add eks https://aws.github.io/eks-charts"
  }
}

resource "null_resource" "k8s_apply_aws_load_balancer_controller" {
  depends_on = [module.eks, null_resource.kubectl_update]
  provisioner "local-exec" {
    command = "kubectl apply -k 'github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master'"
  }
}

resource "null_resource" "helm_install_aws_load_balancer_controller" {
  depends_on = [module.eks, null_resource.k8s_apply_aws_load_balancer_controller]
  provisioner "local-exec" {
    command = "helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=$NAME"
    environment = {
      NAME = var.cluster_name
    }
  }
}

resource "null_resource" "prometheus_install" {
  depends_on = [module.eks, null_resource.k8s_apply_aws_load_balancer_controller]
  provisioner "local-exec" {
    command = "helm repo update && helm install prometheus prometheus-community/prometheus --namespace default --set alertmanager.persistentVolume.storageClass='gp2' --set server.persistentVolume.storageClass='gp2'"
  }
}

resource "null_resource" "grafana_install" {
  depends_on = [module.eks, null_resource.k8s_apply_aws_load_balancer_controller, null_resource.prometheus_install]
  provisioner "local-exec" {
    command = "helm repo update && helm install grafana grafana/grafana --namespace default --set persistence.storageClassName='gp2' --set persistence.enabled=true --set adminUser=$GRAFANA_USER --set adminPassword=$GRAFANA_PASSWORD --values ${path.module}/ymls/grafana.yml --set service.type=LoadBalancer"
    environment = {
      GRAFANA_USER     = var.grafana_user
      GRAFANA_PASSWORD = var.grafana_password
    }
  }
}
