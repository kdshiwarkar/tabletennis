# Use an official Java 8 image as the base
FROM openjdk:8-jdk-alpine

# Set the working directory to /app
WORKDIR /app

# Copy the war file into the container
COPY target/tabletennis.war /app/

# Expose the port that the application will run on
EXPOSE 8080

# Run the command to start the application when the container starts
CMD ["java", "-jar", "tabletennis.war"]
