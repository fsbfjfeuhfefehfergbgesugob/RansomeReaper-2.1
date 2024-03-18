#!/bin/bash

# Check if the script is run with root privileges
if [ $(id -u) -ne 0 ]; then
    echo "This script requires root privileges to run."
    exit 1
fi

# Install Docker
apt update
apt install -y docker.io

# Build the Docker image
docker build -t BotnetAndRat-website .

