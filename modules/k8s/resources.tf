resource "kubernetes_deployment" "terraform-example" {
  metadata {
    name = "terraform-example"
    labels = {
      test = "MyExampleApp"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        test = "MyExampleApp"
      }
    }

    template {
      metadata {
        labels = {
          test = "MyExampleApp"
        }
      }

      spec {
        container {
          image = "nginx:1.7.8"
          name  = "example"

          # resources {
          #   limits {
          #     cpu    = "0.5"
          #     memory = "512Mi"
          #   }
          #   requests {
          #     cpu    = "250m"
          #     memory = "50Mi"
          #   }
          # }

          # liveness_probe {
          #   http_get {
          #     path = "/nginx_status"
          #     port = 80

          #     http_header {
          #       name  = "X-Custom-Header"
          #       value = "Awesome"
          #     }
          #   }

          #   initial_delay_seconds = 3
          #   period_seconds        = 3
          # }
        }
      }
    }
  }
}

resource "kubernetes_service" "terraform-example" {
  metadata {
    name = "terraform-example"
    # test = "MyExampleApp"
  }
  spec {
    selector = {
      test = "MyExampleApp"
    }
    # session_affinity = "ClientIP"
    port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}


# resource "kubernetes_ingress" "terraform-example" {
#   wait_for_load_balancer = false
#   metadata {
#     name = "example-ingress"
#   }

#   spec {
#     backend {
#       service_name = "terraform-example"
#       service_port = 80
#     }

#     rule {
#       http {
#         path {
#           backend {
#             service_name = "terraform-example"
#             service_port = 80
#           }

#           path = "/"
#         }
#       }
#     }
#   }

# }

# resource "kubernetes_ingress" "terraform-example" {
#   wait_for_load_balancer = false
#   metadata {
#     name = "example-ingress"
#     annotations = {
#       # "kubernetes.io/ingress.class" = "nginx"
#       "alb.ingress.kubernetes.io/scheme" = "internet-facing"
#       "kubernetes.io/ingress.class"      = "alb"
#     }
#   }

#   spec {
#     backend {
#       service_name = "terraform-example"
#       service_port = 80
#     }

#     rule {
#       http {
#         path {
#           backend {
#             service_name = "terraform-example"
#             service_port = 80
#           }

#           path = "/"
#         }
#       }
#     }
#   }

# }
