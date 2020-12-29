# resource "helm_release" "ingress" {
#   name       = "nginx-ingress"
#   chart      = "ingress-nginx/ingress-nginx"
#   repository = "https://kubernetes.github.io/ingress-nginx"

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

# resource "helm_release" "ingress" {
#   name = "aws-load-balancer-controller"
#   #   chart      = "ingress-nginx/ingress-nginx"
#   #   repository = "https://kubernetes.github.io/ingress-nginx"
#   #   version    = "0.30.0"
#   chart      = "aws/aws-load-balancer-controller"
#   repository = "https://aws.github.io/eks-charts"
#   version    = "1.1.1"

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

