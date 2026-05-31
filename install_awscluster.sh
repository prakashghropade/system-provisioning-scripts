#!/bin/bash

set -e

set -o pipefail # Return the exit status of the last command in the pipeline that failed.


echo "=========================================="
echo "Starting EKS Cluster Creation"
echo "=========================================="

echo "[1/3] Creating EKS cluster..."
eksctl create cluster --name=wanderlust \
                    --region=ap-south-1 \
                    --version=1.30 \
                    --without-nodegroup
echo "✓ EKS cluster created successfully."

echo "[2/3] Associating IAM OIDC provider..."
eksctl utils associate-iam-oidc-provider \
  --region ap-south-1 \
  --cluster wanderlust \
  --approve
echo "✓ IAM OIDC provider associated successfully."

echo "[3/3] Creating managed node group..."
eksctl create nodegroup --cluster=wanderlust \
                     --region=ap-south-1 \
                     --name=wanderlust \
                     --node-type=t2.large \
                     --nodes=2 \
                     --nodes-min=2 \
                     --nodes-max=2 \
                     --node-volume-size=29 \
                     --ssh-access \
                     --ssh-public-key=docker-aws-key
echo "✓ Node group created successfully."

echo "=========================================="
echo "EKS Cluster Setup Completed"
echo "=========================================="

echo "Cluster Information:"
kubectl get nodes