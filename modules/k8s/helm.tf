# resource "helm_release" "ingress" {
#   name       = "ingress"
#   chart      = "eks/aws-load-balancer-controller"
#   repository = "http://storage.googleapis.com/kubernetes-charts-incubator"
#   version    = "1.0.2"

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
