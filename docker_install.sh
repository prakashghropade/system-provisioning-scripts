#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.

set -o pipefail # Return the exit status of the last command in the pipeline that failed.

echo "Starting the installation of Docker"


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

    echo "Docker installed successfully."
else
    echo "Docker is already installed." 
fi
