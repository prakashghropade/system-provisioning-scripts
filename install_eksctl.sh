#!/bin/bash

set -e

set -o pipefail # Return the exit status of the last command in the pipeline that failed.

echo "=========================================="
echo "Starting eksctl Installation"
echo "=========================================="

echo "[1/3] Downloading eksctl binary..."
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
echo "✓ eksctl binary downloaded successfully."

echo "[2/3] Moving eksctl to /usr/local/bin..."
sudo mv /tmp/eksctl /usr/local/bin
echo "✓ eksctl moved successfully."

echo "[3/3] Verifying eksctl installation..."
eksctl version
echo "✓ eksctl installation verified."

echo "=========================================="
echo "eksctl Installation Completed"
echo "=========================================="