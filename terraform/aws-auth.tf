resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapUsers = yamlencode([
      {
        userarn  = "arn:aws:iam::207567759296:user/preye_aws"
        username = "preye_aws"
        groups   = ["eks-admins"]
      }
    ])
  }

  depends_on = [
    module.eks.aws_eks_cluster,
    module.eks.aws_eks_node_group
  ]
}
