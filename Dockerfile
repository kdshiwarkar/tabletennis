FROM ubuntu:latest

LABEL maintainer="kdshiwarkar@gmail.com"

# Update package repository
RUN apt-get update

# Install dependencies
RUN apt-get install -y --fix-missing curl vim git unzip

# Create directories
WORKDIR /opt/download
RUN mkdir -p extract/java extract/maven extract/tomcat

# Download files
RUN curl -O https://downloads.apache.org/tomcat/tomcat-9/v9.0.91/bin/apache-tomcat-9.0.91.zip \
    && curl -O https://downloads.apache.org/maven/maven-3/3.9.8/binaries/apache-maven-3.9.8-bin.zip \
    && curl -O https://download.java.net/java/GA/jdk11/9/GPL/jdk-11.0.22_linux-x64_bin.zip

# Check if the files are downloaded correctly
RUN if [ ! -f apache-tomcat-9.0.91.zip ]; then echo "Error: Unable to download apache-tomcat-9.0.91.zip"; exit 1; fi \
    && if [ ! -f apache-maven-3.9.8-bin.zip ]; then echo "Error: Unable to download apache-maven-3.9.8-bin.zip"; exit 1; fi \
    && if [ ! -f jdk-11.0.22_linux-x64_bin.zip ]; then echo "Error: Unable to download jdk-11.0.22_linux-x64_bin.zip"; exit 1; fi

# Extract files
RUN unzip apache-tomcat-9.0.91.zip -d extract/tomcat || true \
    && unzip apache-maven-3.9.8-bin.zip -d extract/maven || true \
    && unzip jdk-11.0.22_linux-x64_bin.zip -d extract/java || true

# Check if the extraction was successful
RUN if [ ! -d extract/tomcat ]; then echo "Error: Unable to extract apache-tomcat-9.0.91.zip"; exit 1; fi \
    && if [ ! -d extract/maven ]; then echo "Error: Unable to extract apache-maven-3.9.8-bin.zip"; exit 1; fi \
    && if [ ! -d extract/java ]; then echo "Error: Unable to extract jdk-11.0.22_linux-x64_bin.zip"; exit 1; fi

# Move extracted files to correct directories
RUN mv -f extract/tomcat/apache-tomcat-9.0.91/* extract/tomcat/ && \
    mv -f extract/maven/apache-maven-3.9.8/* extract/maven/

# Set environment variables
ENV JAVA_HOME=/opt/download/extract/java
ENV M2_HOME=/opt/download/extract/maven
ENV PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH
