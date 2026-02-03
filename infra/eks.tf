module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.31.6"
  
  cluster_name    = "sockshop-eks"
  cluster_version = "1.29"
  
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  
  # Enable public endpoint access
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true
  
  eks_managed_node_groups = {
    default = {
      min_size       = 1
      max_size       = 3
      desired_size   = 2
      instance_types = ["t3.small"]
      ami_type       = "AL2_x86_64"
    }
  }
  
  enable_irsa = true
  
  # Enable cluster access for your IAM user
  enable_cluster_creator_admin_permissions = true
  
  access_entries = {
    user1 = {
      principal_arn = "arn:aws:iam::396341923464:user/user1"
      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }
}
