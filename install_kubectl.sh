#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.

set -o pipefail # Return the exit status of the last command in the pipeline that failed.

echo "Starting the installation of kubectl...."
  

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



echo "kubectl version: $(kubectl version --client)"
# Installation completed
echo "Installation of kubectl completed successfully."    