variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "region" {
    description = "Name of the region"
    type = string
    default = "us-east-1"
}

variable "vpc_id" {
    description = "Name of the VPC"
    type = string
}