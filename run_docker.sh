#!/bin/bash

# Check if the script is run with root privileges
if [ $(id -u) -ne 0 ]; then
    echo "This script requires root privileges to run."
    exit 1
fi

# Run the Docker container on startup using systemd
cat << EOF > /etc/systemd/system/sinister-website.service
[Unit]
Description=Sinister Website Docker Container
After=docker.service
Requires=docker.service

[Service]
Restart=always
ExecStart=/usr/bin/docker run -d -p 8080:80 sinister-website

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start the service
systemctl daemon-reload
systemctl enable sinister-website.service
systemctl start sinister-website.service

echo "Docker container for your sinister website is now set to run on startup. Beware the dark presence at http://localhost:8080."
