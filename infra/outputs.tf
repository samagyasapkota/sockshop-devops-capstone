output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "ecr_urls" {
  description = "ECR repository URLs"
  value       = { for k, v in aws_ecr_repository.microservices : k => v.repository_url }
}

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.sockshop.endpoint
  sensitive   = true
}

output "rds_secret_arn" {
  description = "ARN of the secret containing RDS password"
  value       = aws_secretsmanager_secret.db_password.arn
}
