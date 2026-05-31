#!/bin/bash

set -e

set -o pipefail # Return the exit status of the last command in the pipeline that failed.

echo "=========================================="
echo "Starting ArgoCD Installation & Setup"
echo "=========================================="

echo "[1/9] Creating ArgoCD namespace..."
kubectl create namespace argocd
echo "✓ Namespace created successfully."

echo "[2/9] Installing ArgoCD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
echo "✓ ArgoCD manifests applied successfully."

echo "[3/9] Waiting for ArgoCD pods to start..."
watch kubectl get pods -n argocd

echo "[4/9] Installing ArgoCD CLI..."
sudo curl --silent --location -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/v2.4.7/argocd-linux-amd64
echo "✓ ArgoCD CLI downloaded successfully."

echo "[5/9] Adding execute permission to ArgoCD CLI..."
sudo chmod +x /usr/local/bin/argocd
echo "✓ Execute permission added."

echo "[6/9] Checking ArgoCD services..."
kubectl get svc -n argocd

echo "[7/9] Exposing ArgoCD server using NodePort..."
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'
echo "✓ ArgoCD server exposed via NodePort."

echo "[8/9] Verifying services..."
kubectl get svc -n argocd

echo "[9/9] Retrieving initial admin password..."
ARGOCD_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo ""
echo "=========================================="
echo "ArgoCD Installation Completed"
echo "=========================================="

echo ""
echo "ArgoCD Services:"
kubectl get svc -n argocd

echo ""
echo "Initial Admin Credentials:"
echo "Username: admin"
echo "Password: $ARGOCD_PASSWORD"

echo ""
echo "Use the NodePort from the argocd-server service to access the ArgoCD UI."