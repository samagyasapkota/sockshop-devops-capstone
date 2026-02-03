#!/bin/bash

echo "======================================"
echo "Deploying Monitoring Stack"
echo "======================================"
echo ""

# Create monitoring namespace
echo "Creating monitoring namespace..."
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -

# Deploy Prometheus
echo "Deploying Prometheus..."
kubectl apply -f prometheus.yaml

# Deploy Grafana
echo "Deploying Grafana..."
kubectl apply -f grafana.yaml

# Deploy Node Exporter
echo "Deploying Node Exporter..."
kubectl apply -f node-exporter.yaml

# Deploy Kube State Metrics
echo "Deploying Kube State Metrics..."
kubectl apply -f kube-state-metrics.yaml

echo ""
echo "======================================"
echo "Waiting for deployments to be ready..."
echo "======================================"
sleep 10

kubectl wait --for=condition=available --timeout=300s deployment/prometheus -n monitoring
kubectl wait --for=condition=available --timeout=300s deployment/grafana -n monitoring
kubectl wait --for=condition=available --timeout=300s deployment/kube-state-metrics -n monitoring

echo ""
echo "======================================"
echo "Monitoring Stack Deployed!"
echo "======================================"
echo ""

echo "Getting service information..."
echo ""
echo "Prometheus:"
kubectl get svc prometheus -n monitoring
echo ""
echo "Grafana:"
kubectl get svc grafana -n monitoring
echo ""
echo "To access Grafana:"
echo "  Username: admin"
echo "  Password: admin"
echo ""
echo "To port-forward locally:"
echo "  kubectl port-forward -n monitoring svc/prometheus 9090:9090"
echo "  kubectl port-forward -n monitoring svc/grafana 3000:3000"
echo ""
