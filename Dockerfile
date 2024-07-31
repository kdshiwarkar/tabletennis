# Use Ubuntu as the base image
FROM ubuntu:latest

# Update the package lists
RUN apt-get update -qq && apt-get install -y \
    openjdk-11-jdk \
    maven \
    tomcat9 \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the project files
COPY target/tabletennis.war /app/

# Expose the Tomcat port
EXPOSE 8080

# Command to run when the container starts
CMD ["catalina.sh", "run"]


