FROM ubuntu:latest

LABEL maintainer="kdshiwarkar@gmail.com"

# update package list and install packages
RUN apt-get update && apt-get -y upgrade && apt-get install -y git vim wget

# download tomcat, maven, and java
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.91/bin/apache-tomcat-9.0.91.tar.gz && \
    wget https://dlcdn.apache.org/maven/maven-3/3.9.8/binaries/apache-maven-3.9.8-bin.tar.gz && \
    wget https://download.oracle.com/java/22/latest/jdk-22_linux-x64_bin.tar.gz

# extract tar files
RUN tar -xvf apache-tomcat-9.0.91.tar.gz && \
    tar -xvf apache-maven-3.9.8-bin.tar.gz && \
    tar -xvf jdk-22_linux-x64_bin.tar.gz

# Set environment variables
ENV JAVA_HOME /opt/download/jdk-22.0.2
ENV M2_HOME /opt/download/apache-maven-3.9.8
ENV PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH

# Copy war file into container
COPY /home/kunalshiwarkar/.jenkins/workspace/tabletennis/src/target/tabletennis.war /opt/download/apache-tomcat-9.0.91/webapps/

# Start Tomcat on container startup
ENTRYPOINT ["/opt/download/apache-tomcat-9.0.91/bin/startup.sh"]

EXPOSE 8080
