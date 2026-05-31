#!/bin/bash

set -e

set -o pipefail # Return the exit status of the last command in the pipeline that failed.

echo "=========================================="
echo "Starting Trivy Installation"
echo "=========================================="

echo "[1/5] Installing required dependencies..."
sudo apt-get install wget gnupg
echo "✓ Dependencies installed successfully."

echo "[2/5] Adding Trivy GPG key..."
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "✓ Trivy GPG key added successfully."

echo "[3/5] Adding Trivy repository..."
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
echo "✓ Trivy repository added successfully."

echo "[4/5] Updating package index..."
sudo apt-get update
echo "✓ Package index updated successfully."

echo "[5/5] Installing Trivy..."
sudo apt-get install trivy
echo "✓ Trivy installed successfully."

echo "=========================================="
echo "Trivy Installation Completed"
echo "=========================================="

echo "Installed Version:"
trivy --version