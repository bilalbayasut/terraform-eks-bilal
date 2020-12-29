# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

# DEV: COMMENT WHEN YOU DONT WANT K8s TO BE DEPLOYED

provider "helm" {
  # Configuration options
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
    load_config_file       = false
    version                = "~> 1.9"
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

data "aws_eks_cluster" "cluster" {
  name = module.k8s.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.k8s.cluster_id
}
