# Sock Shop Microservices - DevOps Capstone Project

## 📋 Project Overview

A complete DevOps implementation for the Sock Shop microservices application, demonstrating enterprise-grade CI/CD, infrastructure as code, container orchestration, and observability.

## 🏗️ Architecture

### Infrastructure Components
- **Cloud Provider**: AWS
- **Container Registry**: Amazon ECR
- **Kubernetes**: Amazon EKS (v1.29)
- **Database**: Amazon RDS MySQL
- **Networking**: AWS VPC with public/private subnets
- **Load Balancing**: AWS Application Load Balancer

### Microservices
1. **Front-End** - User interface (Node.js)
2. **Catalogue** - Product catalog service (Go)
3. **Carts** - Shopping cart service (Java)
4. **Orders** - Order management (Java)
5. **Payment** - Payment processing (Go)
6. **Shipping** - Shipping service (Java)
7. **User** - User management (Go)
8. **Queue-Master** - Message queue (Java)

## 🚀 Getting Started

### Prerequisites
- AWS Account
- AWS CLI configured
- Terraform >= 1.0
- kubectl >= 1.29
- Docker
- Git

### Infrastructure Deployment

1. **Clone the repository**
```bash
git clone https://github.com/samagyasapkota/sockshop-devops-capstone.git
cd sockshop-devops-capstone
```

2. **Deploy infrastructure with Terraform**
```bash
cd infra
terraform init
terraform plan
terraform apply
```

This creates:
- VPC with public and private subnets
- EKS cluster with 2 worker nodes
- RDS MySQL database
- ECR repositories for all microservices
- Security groups and IAM roles

3. **Configure kubectl**
```bash
aws eks update-kubeconfig --name sockshop-eks --region eu-north-1
```

4. **Verify cluster access**
```bash
kubectl get nodes
```

### Application Deployment

1. **Deploy Sock Shop**
```bash
kubectl create namespace sock-shop
kubectl apply -f deploy/kubernetes/complete-demo.yaml
```

2. **Check deployment status**
```bash
kubectl get pods -n sock-shop
kubectl get svc -n sock-shop
```

3. **Access the application**
```bash
kubectl get svc front-end -n sock-shop
```

Visit the EXTERNAL-IP in your browser.

### Monitoring Setup

1. **Deploy Prometheus & Grafana**
```bash
kubectl apply -f deploy/kubernetes/manifests-monitoring/
```

2. **Access Grafana**
```bash
kubectl get svc grafana -n monitoring
```

Default credentials:
- Username: `admin`
- Password: `admin`

## 🔄 CI/CD Pipeline

### GitHub Actions Workflow

The project uses GitHub Actions for automated CI/CD:

**Pipeline Stages:**
1. **Validate** - Validates Kubernetes manifests
2. **Deploy to Staging** - Deploys to staging on `development` branch
3. **Deploy to Production** - Deploys to production on `main` branch

### Setting Up GitHub Secrets

Add these secrets to your GitHub repository:
```
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
```

### Branching Strategy

- `main` - Production environment
- `development` - Staging environment
- `feature/*` - Feature branches

## 📊 Monitoring & Observability

### Prometheus Metrics

Prometheus is configured to scrape metrics from all microservices.

Access Prometheus:
```bash
kubectl port-forward -n monitoring svc/prometheus 9090:9090
```

### Grafana Dashboards

Pre-configured dashboards for:
- Cluster monitoring
- Application performance
- Resource utilization
- Error rates

## 🔐 Security

- **Network Security**: VPC with public/private subnet isolation
- **Container Security**: ECR image scanning enabled
- **Secrets Management**: AWS Secrets Manager for database credentials
- **RBAC**: Kubernetes role-based access control
- **Security Groups**: Restricted access between services

## 📈 Architecture Diagram
```
┌─────────────────────────────────────────────────────────┐
│                     AWS Cloud                           │
│  ┌───────────────────────────────────────────────────┐ │
│  │              VPC (10.0.0.0/16)                    │ │
│  │  ┌──────────────────┐  ┌──────────────────┐      │ │
│  │  │ Public Subnet    │  │ Private Subnet   │      │ │
│  │  │  - NAT Gateway   │  │  - EKS Nodes     │      │ │
│  │  │  - Load Balancer │  │  - RDS MySQL     │      │ │
│  │  └──────────────────┘  └──────────────────┘      │ │
│  │                                                    │ │
│  │  ┌──────────────────────────────────────┐         │ │
│  │  │      EKS Cluster (v1.29)             │         │ │
│  │  │  ┌────────────────────────────────┐  │         │ │
│  │  │  │  Sock Shop Namespace          │  │         │ │
│  │  │  │  - Front-End                  │  │         │ │
│  │  │  │  - Catalogue                  │  │         │ │
│  │  │  │  - Carts                      │  │         │ │
│  │  │  │  - Orders                     │  │         │ │
│  │  │  │  - Payment                    │  │         │ │
│  │  │  │  - Shipping                   │  │         │ │
│  │  │  │  - User                       │  │         │ │
│  │  │  └────────────────────────────────┘  │         │ │
│  │  │  ┌────────────────────────────────┐  │         │ │
│  │  │  │  Monitoring Namespace         │  │         │ │
│  │  │  │  - Prometheus                 │  │         │ │
│  │  │  │  - Grafana                    │  │         │ │
│  │  │  └────────────────────────────────┘  │         │ │
│  │  └──────────────────────────────────────┘         │ │
│  └───────────────────────────────────────────────────┘ │
│                                                         │
│  ┌──────────────────┐                                  │
│  │      ECR         │ - Container Images               │
│  └──────────────────┘                                  │
└─────────────────────────────────────────────────────────┘
```

## 🧪 Testing

Run validation tests:
```bash
kubectl apply --dry-run=client -f deploy/kubernetes/complete-demo.yaml
```

## 🗑️ Cleanup

To destroy all resources:
```bash
# Delete Kubernetes resources
kubectl delete namespace sock-shop
kubectl delete namespace monitoring

# Destroy infrastructure
cd infra
terraform destroy
```

## 📚 Technologies Used

- **IaC**: Terraform
- **Container Orchestration**: Kubernetes (EKS)
- **CI/CD**: GitHub Actions
- **Monitoring**: Prometheus, Grafana
- **Cloud**: AWS (VPC, EKS, RDS, ECR, ALB)
- **Version Control**: Git/GitHub

## 👨‍💻 Author

**Samagya Sapkota**
- GitHub: [@samagyasapkota](https://github.com/samagyasapkota)

## 📄 License

This project is licensed under the Apache License 2.0 - see the LICENSE file for details.

## 🙏 Acknowledgments

- Weaveworks for the Sock Shop demo application
- Kubernetes community
- AWS documentation
