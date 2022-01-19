data "aws_caller_identity" "current" {}

resource "aws_iam_user" "eks-admin" {
  name = "eks-admin"
  path = "/system/"
}

resource "aws_iam_user_policy" "admin_policy" {
  name = "adminuser"
  user = aws_iam_user.eks-admin.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                    = var.cluster_name
  cluster_version                 = var.cluster_version
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_id

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type               = var.ng_ami_type
    disk_size              = var.ng_disk_size
    instance_types         = [var.ng_instance_types]
    #vpc_security_group_ids = [aws_security_group.additional.id]
  }

  eks_managed_node_groups = {
    eks_nodes = {
      min_size     = var.ng_min_size
      max_size     = var.ng_max_size
      desired_size = var.ng_desired_size

      instance_types = [var.ng_instance_types]
      tags = merge(
      {
        Name = "${lookup(var.default_tags, "AppName", "Provide Proper Key")}-EKS"
      },
      )
    }
  }

  cluster_enabled_log_types = var.cluster_enabled_log_types
}
