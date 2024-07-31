# Use an official Apache Tomcat image as the base
FROM tomcat:9.0

# Set the working directory to /app
WORKDIR /app

# Copy the .war file from the target directory
COPY target/tabletennis.war /app/

# Expose the Tomcat port
EXPOSE 8080

# Run the command to start Tomcat when the container starts
CMD ["catalina.sh", "run"]
