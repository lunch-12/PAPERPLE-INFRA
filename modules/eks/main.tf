resource "aws_eks_cluster" "default" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster-default.arn

  vpc_config {
    subnet_ids = var.cluster_subnet_ids
  }

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.default-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.default-AmazonEKSVPCResourceController,
    aws_cloudwatch_log_group.paperple-cluster-log-group,
    aws_eks_node_group.default
  ]
}

resource "aws_eks_node_group" "default" {
  cluster_name    = var.cluster_name
  node_group_name = "paperple-node-group"
  node_role_arn   = aws_iam_role.node-group-default.arn
  subnet_ids      = var.node_group_subnet_ids
  ami_type        = "AL2_x86_64"

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.default-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.default-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.default-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_eks_addon" "coredns" {
  cluster_name                = var.cluster_name
  addon_name                  = "coredns"
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name                = var.cluster_name
  addon_name                  = "kube-proxy"
}

resource "aws_eks_addon" "vpc-cni" {
  cluster_name                = var.cluster_name
  addon_name                  = "vpc-cni"
}

resource "aws_eks_addon" "eks-pod-identity-agent" {
  cluster_name                = var.cluster_name
  addon_name                  = "eks-pod-identity-agent"
}


resource "aws_cloudwatch_log_group" "paperple-cluster-log-group" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 7
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "cluster-default" {
  name               = "eks-cluster-default-iam-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role" "node-group-default" {
  name = "eks-node-group-default-iam-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_policy" "ca-iam-policy" {
  name        = "cluster-autoscaling"
  description = "Cluster Autoscaling IAM policy"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:DescribeTags",
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup",
          "ec2:DescribeLaunchTemplateVersions"
        ]
        Resource = "*"
        Effect   = "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "default-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster-default.name
}

resource "aws_iam_role_policy_attachment" "default-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.cluster-default.name
}

resource "aws_iam_role_policy_attachment" "default-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node-group-default.name
}

resource "aws_iam_role_policy_attachment" "default-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node-group-default.name
}

resource "aws_iam_role_policy_attachment" "default-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node-group-default.name
}