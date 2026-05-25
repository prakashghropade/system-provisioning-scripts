#!/bin/bash

echo "======================================="
echo " Updating package list"
echo "======================================="
sudo apt update

echo "======================================="
echo " Installing Java 21"
echo "======================================="
sudo apt install fontconfig openjdk-21-jre

echo "======================================="
echo " Checking Java version"
echo "======================================="
java -version

echo "======================================="
echo " Downloading Jenkins key"
echo "======================================="
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "======================================="
echo " Adding Jenkins repository"
echo "======================================="
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null

echo "======================================="
echo " Updating package list again"
echo "======================================="
sudo apt update

echo "======================================="
echo " Installing Jenkins"
echo "======================================="
sudo apt install jenkins

echo "======================================="
echo " Jenkins Initial Admin Password"
echo "======================================="
sudo cat /var/lib/jenkins/secrets/initialAdminPassword