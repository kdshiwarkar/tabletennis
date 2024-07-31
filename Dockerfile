# Use an official Ubuntu image as a base
FROM ubuntu:latest

# Create a directory for devops
RUN mkdir /home/devops

# Install Git
RUN apt-get update && apt-get install -y git

# Install Apache Maven 3.9.7
RUN wget http://archive.apache.org/dist/maven/maven-3/3.9.7/binaries/apache-maven-3.9.7-bin.tar.gz && \
    tar -xvf apache-maven-3.9.7-bin.tar.gz && \
    mv apache-maven-3.9.7 /home/devops/apache-maven-3.9.7 && \
    rm apache-maven-3.9.7-bin.tar.gz

# Install Apache Tomcat 9.0.89
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.89/bin/apache-tomcat-9.0.89.tar.gz && \
    tar -xvf apache-tomcat-9.0.89.tar.gz && \
    mv apache-tomcat-9.0.89 /home/devops/apache-tomcat-9.0.89 && \
    rm apache-tomcat-9.0.89.tar.gz

# Install Java 11.0.22
RUN wget https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.22_linux-x64_bin.tar.gz && \
    tar -xvf openjdk-11.0.22_linux-x64_bin.tar.gz && \
    mv jdk-11.0.22 /home/devops/jdk-11.0.22 && \
    rm openjdk-11.0.22_linux-x64_bin.tar.gz

# Set environment variables
ENV JAVA_HOME=/home/devops/jdk-11.0.22
ENV M2_HOME=/home/devops/apache-maven-3.9.7
ENV PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH

# Change the mode of webapps to 777
RUN chmod 777 /home/devops/apache-tomcat-9.0.89/webapps

# Copy the war file
COPY target/tabletennis.war /home/devops/apache-tomcat-9.0.89/webapps/


