resource "null_resource" "update_kubeconfig" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${aws_eks_cluster.eks_cluster.name} --region ${var.region}"
    on_failure = continue
  }
}

resource "kubernetes_service_account" "alb_ingress_controller_sa" {
    metadata {
        name = "aws-load-balancer-controller"
        namespace = "kube-system"
        annotations = {
            "eks.amazonaws.com/role-arn" = aws_iam_role.alb_ingress_controller_role.arn
        }
    }
    depends_on = [null_resource.update_kubeconfig]
}