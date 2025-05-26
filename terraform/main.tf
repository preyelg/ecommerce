terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name            = "${var.cluster_name}-vpc"
  cidr            = var.vpc_cidr
  azs             = ["us-east-2a", "us-east-2b"]
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway     = true
  single_nat_gateway     = true

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.4.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  subnet_ids = module.vpc.public_subnets
  vpc_id     = module.vpc.vpc_id

  enable_irsa = true
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = false

  eks_managed_node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_types = ["t3.medium"]
      subnet_ids     = module.vpc.private_subnets
      key_name       = var.key_pair_name
    }
  }

  access_entries = {
    preye_user = {
      principal_arn      = "arn:aws:iam::207567759296:user/preye_aws"
      type               = "STANDARD"
      username           = "preye_aws"
      kubernetes_groups  = ["eks-admins"]
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "True"
  }
}

