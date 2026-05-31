#!/bin/bash

set -e

set -o pipefail # Return the exit status of the last command in the pipeline that failed.

echo "=========================================="
echo "Starting kubectl Installation"
echo "=========================================="

echo "[1/4] Downloading kubectl binary..."
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
echo "✓ kubectl binary downloaded successfully."

echo "[2/4] Adding execute permission..."
chmod +x ./kubectl
echo "✓ Execute permission added."

echo "[3/4] Moving kubectl to /usr/local/bin..."
sudo mv ./kubectl /usr/local/bin
echo "✓ kubectl moved successfully."

echo "[4/4] Verifying kubectl installation..."
kubectl version --short --client
echo "✓ kubectl installation verified."

echo "=========================================="
echo "kubectl Installation Completed"
echo "=========================================="