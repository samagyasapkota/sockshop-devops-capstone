# Monitoring Guide

## Overview

The Sock Shop application is monitored using Prometheus and Grafana.

## Accessing Monitoring Tools

### Prometheus
```bash
# Port forward to access locally
kubectl port-forward -n monitoring svc/prometheus 9090:9090

# Or get LoadBalancer URL
kubectl get svc prometheus -n monitoring
```

Access: http://localhost:9090

### Grafana
```bash
# Port forward
kubectl port-forward -n monitoring svc/grafana 3000:3000

# Or get LoadBalancer URL
kubectl get svc grafana -n monitoring
```

Access: http://localhost:3000
- Username: `admin`
- Password: `admin` (change on first login)

## Key Metrics to Monitor

### Application Metrics

1. **Request Rate**
   - Query: `rate(http_requests_total[5m])`
   - Shows requests per second

2. **Error Rate**
   - Query: `rate(http_requests_total{status=~"5.."}[5m])`
   - Shows 5xx errors

3. **Response Time**
   - Query: `histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m]))`
   - 95th percentile response time

### Infrastructure Metrics

1. **CPU Usage**
   - Query: `rate(container_cpu_usage_seconds_total[5m])`

2. **Memory Usage**
   - Query: `container_memory_usage_bytes`

3. **Pod Status**
   - Query: `kube_pod_status_phase`

## Setting Up Alerts

Create alert rules in Prometheus:
```yaml
groups:
  - name: application_alerts
    rules:
      - alert: HighErrorRate
        expr: rate(http_requests_total{status=~"5.."}[5m]) > 0.05
        for: 5m
        annotations:
          summary: "High error rate detected"
      
      - alert: PodDown
        expr: kube_pod_status_phase{phase="Running"} == 0
        for: 5m
        annotations:
          summary: "Pod is down"
```

## Grafana Dashboards

### Pre-configured Dashboards

1. **Kubernetes Cluster Monitoring**
   - Dashboard ID: 7249

2. **Application Performance**
   - Custom dashboard for Sock Shop metrics

3. **Resource Utilization**
   - CPU, Memory, Network metrics

### Import Dashboard

1. Go to Grafana
2. Click "+" → Import
3. Enter Dashboard ID or upload JSON
4. Select Prometheus data source

## Troubleshooting

### Prometheus not scraping metrics
```bash
# Check Prometheus targets
kubectl port-forward -n monitoring svc/prometheus 9090:9090
# Visit http://localhost:9090/targets
```

### Grafana not connecting to Prometheus
```bash
# Check service
kubectl get svc -n monitoring

# Check logs
kubectl logs -n monitoring deployment/grafana
```
