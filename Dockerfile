
FROM docker.io/library/tomcat:9.0
# Rest of your Dockerfile content


# Copy necessary tools and libraries
COPY /home/kunalshiwarkar/Documents/Devops_software/tar/apache-maven-3.9.7 /opt/maven
COPY /home/kunalshiwarkar/Documents/Devops_software/tar/apache-tomcat-9.0.89 /opt/tomcat

# Set environment variables
ENV MAVEN_HOME /opt/maven
ENV PATH $MAVEN_HOME/bin:$PATH
ENV CATALINA_HOME /opt/tomcat

# Copy war file to Tomcat webapps directory
COPY target/tabletennis.war /opt/tomcat/webapps

# Expose Tomcat port
EXPOSE 8080

# Command to run Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
