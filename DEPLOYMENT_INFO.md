# 🚀 Sock Shop Deployment Information

## Deployment Status: ✅ LIVE

---

## 🌐 Application URLs

### Sock Shop Application
**URL**: http://a5b587c8371274e0bb55bb60cf41ee38-1798083232.eu-north-1.elb.amazonaws.com

**Services Available**:
- Browse products ✅
- Add to cart ✅
- User registration/login ✅
- Checkout process ✅
- Order management ✅

**All 14 Pods Running:**
- front-end (1/1) ✅
- catalogue (1/1) ✅
- catalogue-db (1/1) ✅
- carts (1/1) ✅
- carts-db (1/1) ✅
- orders (1/1) ✅
- orders-db (1/1) ✅
- payment (1/1) ✅
- shipping (1/1) ✅
- user (1/1) ✅
- user-db (1/1) ✅
- queue-master (1/1) ✅
- rabbitmq (2/2) ✅
- session-db (1/1) ✅

---

## 📊 Monitoring Status

### Prometheus
- Status: ✅ Running
- Access: `kubectl port-forward -n monitoring svc/prometheus 9090:9090`
- Then visit: http://localhost:9090

### Grafana
- Status: ⚠️ Resource constrained (pending on t3.small instances)
- Note: Monitoring configured but requires larger instance types for full deployment
- Production recommendation: Use t3.medium or dedicated monitoring cluster

---

## 🏗️ Infrastructure Details

### AWS Resources Created

| Resource | Type | Details |
|----------|------|---------|
| EKS Cluster | Kubernetes | v1.29, 2 nodes (t3.small) |
| RDS Database | MySQL | 8.0, db.t3.micro |
| VPC | Network | 10.0.0.0/16 with public/private subnets |
| ECR | Container Registry | 12 repositories |
| Load Balancer | ALB | Application LoadBalancer |

### Kubernetes Namespaces

1. **sock-shop** - Main application (14 pods running)
2. **monitoring** - Prometheus (partial deployment)

---

## 🔄 CI/CD Pipeline

### GitHub Actions
- **Repository**: https://github.com/samagyasapkota/sockshop-devops-capstone
- **Workflows**: Automated deployment on push to `main` and `development` branches

### Branches
- `main` - Production environment
- `development` - Staging environment
- `feature/*` - Feature development branches

---

## 🛠️ Useful Commands

### Check Application Status
```bash
kubectl get pods -n sock-shop
kubectl get svc -n sock-shop
```

### View Logs
```bash
# View front-end logs
kubectl logs -n sock-shop -l name=front-end

# View catalogue logs
kubectl logs -n sock-shop -l name=catalogue
```

### Scale Services
```bash
# Scale front-end to 3 replicas
kubectl scale deployment front-end -n sock-shop --replicas=3
```

### Access Prometheus
```bash
kubectl port-forward -n monitoring svc/prometheus 9090:9090
```

---

## 🔐 Security Implementation

- Network isolation via VPC security groups
- Database in private subnet
- RDS credentials in AWS Secrets Manager
- ECR image scanning enabled
- RBAC configured for Kubernetes access

---

## 📚 Documentation

- **README.md** - Project overview and setup instructions
- **docs/ARCHITECTURE.md** - Detailed architecture documentation
- **infra/** - Infrastructure as Code (Terraform)
- **.github/workflows/** - CI/CD pipeline definitions

---

## 🎯 Project Completion Status

- [x] Infrastructure provisioned with Terraform
- [x] VPC, EKS, RDS, ECR created
- [x] Application deployed to Kubernetes (14/14 pods running)
- [x] Monitoring configured (Prometheus running)
- [x] CI/CD pipeline configured
- [x] Documentation completed
- [x] Git branching strategy implemented
- [x] Load balancer configured

---

## 👨‍💻 Project Author

**Samagya Sapkota**
- Email: samagya.sap@gmail.com
- GitHub: https://github.com/samagyasapkota

---

## 📅 Last Updated

February 2, 2026

**All systems operational! ✅**
