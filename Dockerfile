# Use an official Apache image as a base
FROM httpd:2.4

# Set the working directory to /usr/local/apache2/htdocs
WORKDIR /usr/local/apache2/htdocs

# Copy the war file from the current directory (i.e. the directory where the Dockerfile is located)
COPY target/tabletennis.war /usr/local/apache2/htdocs/

# Expose the port 80
EXPOSE 80

# Run the command to start the Apache server when the container starts
CMD ["httpd", "-D", "FOREGROUND"]

