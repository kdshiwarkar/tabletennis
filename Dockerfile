# Use an official Java image as a base
FROM openjdk:22

# Set the working directory to /opt/download
WORKDIR /opt/download

# Update package list
RUN apt-get update

# Upgrade package list
RUN apt-get -y upgrade

# Install package
RUN apt-get install -y git
RUN apt-get install -y vim
RUN apt-get update
RUN apt-get install -y wget

# Download Tomcat, Maven, and Java
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.91/bin/apache-tomcat-9.0.91.tar.gz
RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.8/binaries/apache-maven-3.9.8-bin.tar.gz

# Extract tar files
RUN tar -xvf apache-tomcat-9.0.91.tar.gz 
RUN tar -xvf apache-maven-3.9.8-bin.tar.gz 

# Set environment variables
ENV JAVA_HOME /opt/download/jdk-22.0.2
ENV M2_HOME /opt/download/apache-maven-3.9.8
ENV PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH

# Copy environment variables to .bashrc
RUN echo "export JAVA_HOME=$JAVA_HOME" >> /root/.bashrc
RUN echo "export M2_HOME=$M2_HOME" >> /root/.bashrc
RUN echo "export PATH=$PATH" >> /root/.bashrc

# Start Tomcat on container startup
CMD ["/opt/download/apache-tomcat-9.0.91/bin/startup.sh"]
EXPOSE 8080
