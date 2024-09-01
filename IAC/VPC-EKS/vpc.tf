module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"
  name = local.name
  cidr = local.vpc_cidr
  azs = local.azs

  private_subnets     =  [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  public_subnets      =  [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]

  map_public_ip_on_launch = true


# NAT gateways - Outbound communication
  enable_nat_gateway = true
  single_nat_gateway = true

# VPC DNS parameters
  enable_dns_hostnames = true
  enable_dns_support = true

  public_subnet_tags = {
    Type = "public-subnets"
    kubernetes.io/role/elb: 1
  }

  private_subnet_tags = {
    Type = "private-subnets"
    kubernetes.io/role/internal-elb: 1
  }

 
  tags = local.common_tags

  vpc_tags = {
    Name = "vpc-dev"
  }
}