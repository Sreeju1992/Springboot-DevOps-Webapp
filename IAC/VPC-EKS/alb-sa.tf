resource "kubernetes_service_account" "alb_ingress_controller_sa" {
    metadata {
        name = "aws-load-balancer-controller"
        namespace = "kube-system"
        annotations = {
            "eks.amazonaws.com/role-arn" = aws_iam_role.alb_ingress_controller_role.arn
        }
    }
    depends_on = [aws_eks_cluster.eks_cluster,aws_eks_node_group.eks_ng_private,aws_eks_node_group.eks_ng_public]
}