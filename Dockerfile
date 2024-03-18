# Use a base image
FROM nginx:latest

# Copy your HTML file into the container
COPY hookbotnet.html /usr/share/nginx/html

# Expose port 80
EXPOSE 8080