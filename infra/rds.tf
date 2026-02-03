# Security group for RDS
resource "aws_security_group" "rds" {
  name        = "sockshop-rds-sg"
  description = "Security group for RDS database"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [module.eks.node_security_group_id]
    description     = "Allow MySQL access from EKS nodes"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sockshop-rds-sg"
  }
}

# DB Subnet Group
resource "aws_db_subnet_group" "sockshop" {
  name       = "sockshop-db-subnet"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "SockShop DB subnet group"
  }
}

# Create random password for RDS
resource "random_password" "db_password" {
  length  = 16
  special = true
}

# Store password in AWS Secrets Manager
resource "aws_secretsmanager_secret" "db_password" {
  name = "sockshop-db-password"
  description = "RDS database password for Sock Shop"
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = random_password.db_password.result
}

# RDS MySQL Instance (Free Tier Compatible)
resource "aws_db_instance" "sockshop" {
  identifier           = "sockshop-db"
  engine              = "mysql"
  engine_version      = "8.0"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  storage_type        = "gp2"  # Changed from gp3 for free tier
  
  db_name  = "socksdb"
  username = "sockshop_admin"
  password = random_password.db_password.result
  
  db_subnet_group_name   = aws_db_subnet_group.sockshop.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  
  backup_retention_period = 0  # Changed from 7 for free tier
  
  skip_final_snapshot    = true
  publicly_accessible    = false

  tags = {
    Name      = "sockshop-database"
    ManagedBy = "Terraform"
  }
}
