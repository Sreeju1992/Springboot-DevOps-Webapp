module "eks" {
   source  = "terraform-aws-modules/eks/aws"
   version = "20.0"

   cluster_name    = "${local.name}-${var.cluster_name}"
   cluster_version = var.cluster_version
   cluster_endpoint_public_access = var.cluster_endpoint_public_access
   cluster_endpoint_private_access = var.cluster_endpoint_private_access
   cluster_service_ipv4_cidr = var.cluster_service_ipv4_cidr

   # EKS Addons
   cluster_addons = {
     coredns                = {}
     eks-pod-identity-agent = {}
     kube-proxy             = {}
     vpc-cni                = {}
   }

   vpc_id     = module.vpc.vpc_id
   subnet_ids = module.vpc.private_subnets

   enable_irsa = true

   eks_managed_node_groups = {
      private_node_group = {
        ami_type       = var.ami_type
        instance_types = var.instance_types
        min_size       = var.min_size
        max_size       = var.max_size
        desired_size   = var.desired_size
      } 
   }

   tags = local.common_tags