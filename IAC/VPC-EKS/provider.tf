provider "aws" {
    region = local.region
}

provider "kubernetes" {
  host                   = aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks_cluster.token
}


provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

# Terraform block
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.32.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.15.0"
    }
  }
}

