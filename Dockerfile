FROM ubuntu:latest

LABEL maintainer="kdshiwarkar@gmail.com"

# Increase Acquire::http::Pipeline-Depth to 10
RUN echo 'Acquire::http::Pipeline-Depth "10";' >> /etc/apt/apt.conf.d/99custom

# Update package repository
RUN apt-get update

# Install dependencies
RUN apt-get install -y --fix-missing curl vim git
RUN sed -i '/archive.ubuntu.com/mirrors.kernel.org/g' /etc/apt/sources.list

# Create directories
WORKDIR /opt/download
RUN mkdir -p extract/java extract/maven extract/tomcat

# Download files
RUN curl -O https://downloads.apache.org/tomcat/tomcat-9/v9.0.91/bin/apache-tomcat-9.0.91.tar.gz \
    && curl -O https://downloads.apache.org/maven/maven-3/3.9.8/binaries/apache-maven-3.9.8-bin.tar.gz \
    && curl -O https://download.java.net/java/GA/jdk11/9/GPL/jdk-11.0.22_linux-x64_bin.tar.gz

# Extract files
RUN sha256sum apache-tomcat-9.0.91.tar.gz apache-maven-3.9.8-bin.tar.gz jdk-11.0.22_linux-x64_bin.tar.gz \
    && tar -xf apache-tomcat-9.0.91.tar.gz -C extract/tomcat \
    && tar -xf apache-maven-3.9.8-bin.tar.gz -C extract/maven \
    && tar -xf jdk-11.0.22_linux-x64_bin.tar.gz -C extract/java

# Move extracted files to correct directories
RUN mv -f extract/tomcat/apache-tomcat-9.0.91/* extract/tomcat/ && \
    mv -f extract/maven/apache-maven-3.9.8/* extract/maven/ && \
    mv -f extract/java/jdk-11.0.22/* extract/java/

# Remove unnecessary files
RUN rm -rf apache-tomcat-9.0.91.tar.gz apache-maven-3.9.8-bin.tar.gz jdk-11.0.22_linux-x64_bin.tar.gz

# Set environment variables
ENV JAVA_HOME=/opt/download/extract/java
ENV M2_HOME=/opt/download/extract/maven
ENV PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH
