#!/bin/bash

set -e

set -o pipefail # Return the exit status of the last command in the pipeline that failed.

echo "=========================================="
echo "Starting AWS CLI v2 Installation"
echo "=========================================="

echo "[1/4] Downloading AWS CLI package..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
echo "✓ AWS CLI package downloaded successfully."

echo "[2/4] Installing unzip package..."
sudo apt install unzip -y
echo "✓ unzip installed successfully."

echo "[3/4] Extracting AWS CLI package..."
unzip awscliv2.zip
echo "✓ AWS CLI package extracted successfully."

echo "[4/4] Installing AWS CLI..."
sudo ./aws/install
echo "✓ AWS CLI installed successfully."

echo "=========================================="
echo "AWS CLI Installation Completed"
echo "=========================================="

echo "Installed Version:"
aws --version