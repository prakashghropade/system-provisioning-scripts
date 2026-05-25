#!/bin/bash

# ============================================
# Jenkins Installation Script for Ubuntu
# Installs:
# - Java 21 (OpenJDK)
# - Jenkins
# ============================================

set -e

set -o pipefail # Return the exit status of the last command in the pipeline that failed.

echo "============================================"
echo " Updating package list..."
echo "============================================"
sudo apt update -y

echo "============================================"
echo " Installing Java 21..."
echo "============================================"
sudo apt install -y fontconfig openjdk-21-jre

echo "============================================"
echo " Checking Java version..."
echo "============================================"
java -version

echo "============================================"
echo " Creating keyrings directory..."
echo "============================================"
sudo mkdir -p /etc/apt/keyrings

echo "============================================"
echo " Downloading Jenkins GPG key..."
echo "============================================"
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "============================================"
echo " Adding Jenkins repository..."
echo "============================================"
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/" | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "============================================"
echo " Updating package list again..."
echo "============================================"
sudo apt update -y

echo "============================================"
echo " Installing Jenkins..."
echo "============================================"
sudo apt install -y jenkins

echo "============================================"
echo " Starting Jenkins service..."
echo "============================================"
sudo systemctl start jenkins

echo "============================================"
echo " Enabling Jenkins on boot..."
echo "============================================"
sudo systemctl enable jenkins

echo "============================================"
echo " Checking Jenkins service status..."
echo "============================================"
sudo systemctl status jenkins --no-pager

echo "============================================"
echo " Jenkins Installation Completed Successfully!"
echo "============================================"

echo "Access Jenkins at:"
echo "http://<YOUR_SERVER_IP>:8080"

echo "Initial Admin Password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword