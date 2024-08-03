FROM ubuntu:latest

LABEL maintainer="kdshiwarkar@gmail.com"

# Use a mirror repository
RUN sed -i 's/archive.ubuntu.com/mirrors.kernel.org/g' /etc/apt/sources.list

# Update package repository and clean package cache
RUN apt-get update && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt-get install -y --fix-missing curl vim git unzip

# Create directories
WORKDIR /opt/download
RUN mkdir -p extract/java extract/maven extract/tomcat

# Download files
RUN curl -O https://downloads.apache.org/tomcat/tomcat-9/v9.0.91/bin/apache-tomcat-9.0.91.zip \
    && curl -O https://downloads.apache.org/maven/maven-3/3.9.8/binaries/apache-maven-3.9.8-bin.zip \
    && curl -O https://download.java.net/java/GA/jdk11/9/GPL/jdk-11.0.22_linux-x64_bin.zip

# Extract files
RUN unzip apache-tomcat-9.0.91.zip -d extract/tomcat \
    && unzip apache-maven-3.9.8-bin.zip -d extract/maven \
    && unzip jdk-11.0.22_linux-x64_bin.zip -d extract/java

# Move extracted files to correct directories
RUN mv -f extract/tomcat/apache-tomcat-9.0.91/* extract/tomcat/ && \
    mv -f extract/maven/apache-maven-3.9.8/* extract/maven/ && \
    mv -f extract/java/jdk-11.0.22/* extract/java/

# Remove unnecessary files
RUN rm -rf apache-tomcat-9.0.91.zip apache-maven-3.9.8-bin.zip jdk-11.0.22_linux-x64_bin.zip

# Set environment variables
ENV JAVA_HOME=/opt/download/extract/java
ENV M2_HOME=/opt/download/extract/maven
ENV PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH
