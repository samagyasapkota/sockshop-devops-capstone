# ECR Repositories for Sock Shop Microservices
locals {
  microservices = [
    "front-end",
    "catalogue",
    "catalogue-db",
    "carts",
    "carts-db",
    "orders",
    "orders-db",
    "shipping",
    "queue-master",
    "payment",
    "user",
    "user-db"
  ]
}

resource "aws_ecr_repository" "microservices" {
  for_each = toset(local.microservices)

  name                 = "sockshop/${each.key}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Project   = "SockShop"
    ManagedBy = "Terraform"
  }
}

resource "aws_ecr_lifecycle_policy" "microservices" {
  for_each   = aws_ecr_repository.microservices
  repository = each.value.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep last 10 images"
      selection = {
        tagStatus     = "any"
        countType     = "imageCountMoreThan"
        countNumber   = 10
      }
      action = {
        type = "expire"
      }
    }]
  })
}
