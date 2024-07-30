# Use an official Tomcat 9.0.89 image as the base
FROM tomcat:9.0.89-jdk-11

# Set the working directory to /usr/local/tomcat
WORKDIR /usr/local/tomcat

# Copy the WAR file to the webapps directory
COPY target/tabletennis.war /usr/local/tomcat/webapps/

# Expose the port for Tomcat
EXPOSE 8080

# Set the default command to run when the container starts
CMD ["catalina.sh", "run"]
