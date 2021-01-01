resource "kubernetes_deployment" "terraform-example" {
  depends_on = [module.eks]
  metadata {
    name = "terraform-example"
    labels = {
      app = "terraform-example"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "terraform-example"
      }
    }

    template {
      metadata {
        labels = {
          app = "terraform-example"
        }
      }

      spec {
        container {
          image = "nginx:1.7.8"
          name  = "terraform-example"

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
  depends_on = [module.eks]
  metadata {
    name = "terraform-example"
  }
  spec {
    selector = {
      app = "terraform-example"
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "NodePort"
  }
}

resource "kubernetes_ingress" "terraform-example" {
  depends_on             = [module.eks, null_resource.helm_install_aws_load_balancer_controller]
  wait_for_load_balancer = false
  metadata {
    name = "terraform-example-ingress"
    annotations = {
      # "kubernetes.io/ingress.class" = "nginx"
      "alb.ingress.kubernetes.io/scheme" = "internet-facing"
      "kubernetes.io/ingress.class"      = "alb"
    }
  }

  spec {
    backend {
      service_name = "terraform-example"
      service_port = 80
    }

    rule {
      http {
        path {
          backend {
            service_name = "terraform-example"
            service_port = 80
          }

          path = "/"
        }
      }
    }
  }

}
