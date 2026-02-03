#!/bin/bash

echo "========================================="
echo "Sock Shop Deployment Verification"
echo "========================================="
echo ""

echo "✓ Checking Kubernetes cluster connection..."
kubectl cluster-info | head -1

echo ""
echo "✓ Checking EKS nodes..."
kubectl get nodes

echo ""
echo "✓ Checking Sock Shop pods..."
kubectl get pods -n sock-shop

echo ""
echo "✓ Checking Sock Shop services..."
kubectl get svc -n sock-shop

echo ""
echo "✓ Checking Monitoring pods..."
kubectl get pods -n monitoring

echo ""
echo "✓ Checking Monitoring services..."
kubectl get svc -n monitoring

echo ""
echo "========================================="
echo "Application URLs:"
echo "========================================="
echo "Sock Shop: http://$(kubectl get svc front-end -n sock-shop -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')"
echo "Grafana: http://$(kubectl get svc grafana -n monitoring -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')"
echo ""
echo "✓ Deployment verification complete!"
