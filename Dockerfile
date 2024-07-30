# Use an official Maven image as the base
FROM maven:3.9.7-jdk-11

# Set the working directory to /app
WORKDIR /app

# Copy the pom.xml file to the working directory
COPY pom.xml /app/

# Install the dependencies
RUN mvn install

# Copy the rest of the application code to the working directory
COPY . /app/

# Build the war file
RUN mvn package

# Expose the port for the Tomcat server
EXPOSE 8080

# Copy the war file to the Tomcat webapps directory
RUN cp target/tabletennis.war /usr/local/tomcat/webapps/

# Use the official Tomcat image as the base for the final image
FROM tomcat:9.0.89-jdk-11

# Copy the webapps directory from the previous image
COPY --from=0 /usr/local/tomcat/webapps/ /usr/local/tomcat/webapps/

# Set the default command to run when the container starts
CMD ["catalina.sh", "run"]
