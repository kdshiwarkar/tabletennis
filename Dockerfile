# Use an official Nginx image as a base
FROM nginx:latest

# Set the working directory to /app
WORKDIR /app

# Copy the war file from the current directory (i.e. the Jenkins workspace)
# into the container at /app
COPY target/tabletennis.war /app/

# Configure Nginx to serve the war file
RUN echo "server { \
        listen 80; \
        location / { \
            proxy_pass http://localhost:8080; \
            proxy_set_header Host $host; \
            proxy_set_header X-Real-IP $remote_addr; \
        } \
    }" > /etc/nginx/conf.d/default.conf

# Expose the port 80
EXPOSE 80

# Run Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]


