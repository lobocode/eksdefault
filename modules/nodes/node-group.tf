resource "aws_eks_node_group" "cluster" {
    cluster_name = var.eks_cluster.name
    node_group_name = format("%s-node-group", var.cluster_name)
    node_role_arn = aws_iam_role.eks_node_role.arn

    subnet_ids = [
        var.private_subnet_1a[0],
        var.private_subnet_1c[0]
    ]

    instance_types = var.nodes_instances_sizes

    scaling_config {
        desired_size    = lookup(var.auto_scale_options, "2")
        max_size        = lookup(var.auto_scale_options, "6")
        min_size        = lookup(var.auto_scale_options, "2")
    }

    tags = {
        "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    }

}