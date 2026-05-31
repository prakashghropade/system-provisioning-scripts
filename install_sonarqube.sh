#!/bin/bash

set -e

set -o pipefail # Return the exit status of the last command in the pipeline that failed.

echo "=========================================="
echo "Starting SonarQube Deployment"
echo "=========================================="

echo "[1/2] Pulling SonarQube LTS Community image..."
docker pull sonarqube:lts-community
echo "✓ SonarQube image downloaded successfully."

echo "[2/2] Starting SonarQube container..."
docker run -itd --name SonarQube-Server -p 9000:9000 sonarqube:lts-community
echo "✓ SonarQube container started successfully."

echo "=========================================="
echo "SonarQube Deployment Completed"
echo "=========================================="

echo "Container Status:"
docker ps | grep SonarQube-Server || true

echo ""
echo "Access SonarQube at:"
echo "http://<SERVER-IP>:9000"
echo ""
echo "Default Credentials:"
echo "Username: admin"
echo "Password: admin"