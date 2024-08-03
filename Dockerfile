FROM ubuntu:latest

MAINTAINER "kdshiwarkar@gmail.com"

# Install dependencies
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install vim
RUN apt-get clean && apt-get autoclean
RUN apt-get -y install openssh-server
RUN apt-get update
RUN apt-get clean && apt-get autoclean
RUN apt-get install -y libgdbm-compat4t64 libgdbm6t64
RUN apt-get install -y git

# Create directories
RUN mkdir -p /opt/download/extract
RUN mkdir -p /opt/download/extract/java
RUN mkdir -p /opt/download/extract/maven
RUN mkdir -p /opt/download/extract/tomcat

# Download and extract Tomcat, Maven, and Java
WORKDIR /opt/download/
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.91/bin/apache-tomcat-9.0.91.tar.gz
RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.8/binaries/apache-maven-3.9.8-bin.tar.gz
RUN wget https://www.oracle.com/webapps/redirect/signon?nexturl=https://download.oracle.com/otn/java/jdk/11.0.22%2B7/9bd8d305c900ee4fa3e613b59e6f42de/jdk-11.0.22_linux-x64_bin.tar.gz
ADD apache-tomcat-9.0.91.tar.gz /opt/download/
ADD apache-maven-3.9.8-bin.tar.gz /opt/download/
RUN tar -zxf apache-tomcat-9.0.91.tar.gz
RUN tar -zxf apache-maven-3.9.8-bin.tar.gz
RUN tar -zxf jdk-11.0.22_linux-x64_bin.tar.gz

# Move extracted files to correct directories
RUN mv -f apache-tomcat-9.0.91.tar.gz/* /opt/download/extract/tomcat
RUN mv -f apache-maven-3.9.8/* /opt/download/extract/maven
RUN mv -f jdk-11.0.22/* /opt/download/java

# Remove unnecessary files
RUN rm -rf jdk-11.0.22_linux-x64_bin.tar.gz jdk-11.0.22
RUN rm -rf apache-maven-3.9.8-bin.tar.gz apache-maven-3.9.8
RUN rm -rf apache-tomcat-9.0.91.tar.gz apache-tomcat-9.0.91

# Set environment variables
ENV JAVA_HOME=/opt/download/extract/java
ENV M2_HOME=/opt/download/extract/maven
ENV PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH

# Create script directory and copy scripts
RUN mkdir /Script
WORKDIR /Script
COPY create_mvn_folder.sh .
ADD git_add.sh .
RUN chmod 755 create_mvn_folder.sh
RUN chmod 755 git_add.sh

# Set working directory to /
WORKDIR /
