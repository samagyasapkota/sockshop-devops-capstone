# Setup Guide

## Prerequisites

- AWS Account with admin access
- AWS CLI configured
- Terraform >= 1.0
- kubectl >= 1.29
- Git

## Step 1: Clone Repository
```bash
git clone https://github.com/samagyasapkota/sockshop-devops-capstone.git
cd sockshop-devops-capstone
```

## Step 2: Deploy Infrastructure
```bash
cd infra

# Initialize Terraform
terraform init

# Review the plan
terraform plan

# Apply infrastructure
terraform apply -auto-approve
```

This creates:
- VPC with subnets
- EKS cluster
- RDS database
- ECR repositories
- Security groups

## Step 3: Configure kubectl
```bash
aws eks update-kubeconfig --name sockshop-eks --region eu-north-1
kubectl get nodes
```

## Step 4: Deploy Application
```bash
# Create namespace
kubectl create namespace sock-shop

# Deploy application
kubectl apply -f deploy/kubernetes/complete-demo.yaml -n sock-shop

# Check deployment
kubectl get pods -n sock-shop
```

## Step 5: Expose Application
```bash
# Patch service to use LoadBalancer
kubectl patch svc front-end -n sock-shop -p '{"spec": {"type": "LoadBalancer"}}'

# Get URL
kubectl get svc front-end -n sock-shop
```

## Step 6: Deploy Monitoring
```bash
# Create monitoring namespace
kubectl create namespace monitoring

# Deploy Prometheus and Grafana
kubectl apply -f monitoring/prometheus.yaml
kubectl apply -f monitoring-lightweight.yaml

# Get Grafana URL
kubectl get svc grafana -n monitoring
```

## Step 7: Setup CI/CD

1. Go to GitHub repository settings
2. Add secrets:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
3. Push to `main` branch to trigger deployment

## Troubleshooting

### Pods not starting
```bash
kubectl describe pod <pod-name> -n sock-shop
kubectl logs <pod-name> -n sock-shop
```

### Cannot connect to cluster
```bash
aws eks update-kubeconfig --name sockshop-eks --region eu-north-1
```

### Terraform errors
```bash
cd infra
terraform destroy
terraform apply
```
