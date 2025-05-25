variable "aws_region" {
  default = "us-east-2"
}

variable "cluster_name" {
  default = "ecommerce-cluster"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "key_pair_name" {
  description = "Name of the existing EC2 Key Pair"
  type        = string
  default     = "linux"
}
