# Use the official Nginx image as the base image
FROM nginx:latest

# Copy the static website files to the Nginx web root directory
COPY website/index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
