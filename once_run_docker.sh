#!/bin/bash

# Check if the script is run with root privileges
if [ $(id -u) -ne 0 ]; then
    echo "This script requires root privileges to run."
    exit 1
fi

# Run the Docker container
docker run -d -p 8080:80 sinister-website

echo "Docker container for your sinister website is now running. Access it at http://localhost:8080."
