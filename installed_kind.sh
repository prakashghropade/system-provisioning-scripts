#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.

set -o pipefail # Return the exit status of the last command in the pipeline that failed.

echo "Starting the installation of Docker, kind adn kubectl...."


# ========================================================
# Install Docker
# ========================================================


if ! command -v docker &>/dev/null; then
    echo "Docker not found. Installing Docker..."
    # Installing the docker
    echo "Installing Docker..."
    sudo apt-get update
    sudo apt-get install -y docker.io

    echo "Adding the current user to docker group"
    sudo usermod -aG docker $USER
    sudo newgrp docker

    echo "Docker installed successfully."
else
    echo "Docker is already installed." 
fi


# ========================================================
# Install kind
# ========================================================

if ! command -v kind &>/dev/null; then
    echo "kind not found. Installing kind..."
    # Installing the kind 

    echo "Installing kind..."

    ARCH=$(uname -m)
    if [ "$ARCH" == "x86_64" ]; then 
         curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-amd64
    elif [ "$ARCH" == "aarch64" ]; then
        curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-arm64
    else
        echo "Unsupported architecture: $ARCH"
        exit 1
    fi

    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
    echo "kind installed successfully."
else
    echo "kind is already installed."
fi
     

# ========================================================
# Install kubectl
# ========================================================

if ! command -v kubectl &>/dev/null; then
    echo "kubectl not found. Installing kubectl..."
    # Installing the kubectl

    echo "Installing kubectl..."

    ARCH=$(uname -m)
    if [ "$ARCH" == "x86_64" ]; then 
           curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    elif [ "$ARCH" == "aarch64" ]; then
           curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl"
    else
        echo "Unsupported architecture: $ARCH"
        exit 1
    fi

    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
    echo "kubectl installed successfully."
else
    echo "kubectl is already installed."
fi

    