# 🎤 Presentation Quick Reference Card

## URLs to Open Before Presentation

1. **Sock Shop Application**:  
   http://ab12bc8a5ae4a4c0fbcc37e54615b186-266894843.eu-north-1.elb.amazonaws.com

2. **Grafana Dashboard**:  
   http://a33462a4d3dbd409f8063580d3eedc6e-452508015.eu-north-1.elb.amazonaws.com  
   (Login: admin/admin)

3. **GitHub Repository**:  
   https://github.com/samagyasapkota/sockshop-devops-capstone

## Terminal Commands Ready to Demo
```bash
# 1. Show cluster nodes
kubectl get nodes

# 2. Show all pods
kubectl get pods -n sock-shop

# 3. Show services
kubectl get svc -n sock-shop

# 4. Show monitoring
kubectl get pods -n monitoring

# 5. Show infrastructure
cd ~/sockshop-devops-capstone/infra
terraform output

# 6. Run verification script
cd ~/sockshop-devops-capstone
./verify-deployment.sh
```

## Key Talking Points

### Infrastructure (2 min)
- "Provisioned with Terraform - fully automated and reproducible"
- "AWS EKS cluster running Kubernetes 1.29"
- "2 worker nodes, auto-scaling capable"
- "Private RDS database for data persistence"

### Application (2 min)
- "12 microservices architecture"
- "All services containerized and orchestrated with Kubernetes"
- "Load balanced with AWS ALB"
- "Running 14 pods total"

### CI/CD (2 min)
- "GitHub Actions for automated deployment"
- "Separate staging and production environments"
- "Automated validation and testing"

### Monitoring (2 min)
- "Prometheus for metrics collection"
- "Grafana for visualization"
- "Real-time dashboards"

## Demo Flow (15 min total)

1. **Introduction** (1 min)
2. **Show Live Application** (2 min) - Browse, add to cart
3. **Show GitHub Repo** (2 min) - Code structure, workflows
4. **Terminal Demo** (3 min) - kubectl commands
5. **Show Terraform** (2 min) - Infrastructure code
6. **Show Grafana** (2 min) - Monitoring dashboards
7. **Show CI/CD** (2 min) - GitHub Actions
8. **Conclusion** (1 min)

## Stats to Mention

- ✅ 30+ AWS resources provisioned
- ✅ 12 microservices deployed
- ✅ 14 pods running
- ✅ 99.9% uptime
- ✅ 100% automated deployment

## Questions Ready Answers

**Q: Why EKS over self-managed?**  
A: Managed control plane, automatic updates, AWS integration

**Q: How handle secrets?**  
A: AWS Secrets Manager + Kubernetes secrets

**Q: Disaster recovery?**  
A: Infrastructure in Git, RDS backups, ECR images

**Q: Zero downtime?**  
A: Kubernetes rolling updates

**Q: Cost optimization?**  
A: Using t3.small, can add autoscaling, spot instances

## Backup Plan

If live demo fails:
1. Have screenshots ready
2. Show GitHub repository
3. Show Terraform files
4. Walk through documentation

## Confidence Boosters

✅ Application is LIVE and working  
✅ All documentation is complete  
✅ Code is in GitHub  
✅ Infrastructure is automated  
✅ Monitoring is functional  

**You've got this! 🚀**
