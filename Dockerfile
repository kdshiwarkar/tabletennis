FROM ubuntu:latest
MAINTAINER "kdshiwarkar@gmail.com"
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install vim
RUN apt-get clean && apt-get autoclean
RUN apt-get -y install openssh-server
RUN apt-get -y install git
RUN mkdir -p /opt/download/extract
RUN mkdir -p /opt/download/extract/java
RUN mkdir -p /opt/download/extract/maven
RUN mkdir -p /opt/download/extract/tomcat
WORKDIR /opt/download/
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.91/bin/apache-tomcat-9.0.91.tar.gz
ADD https://dlcdn.apache.org/maven/maven-3/3.9.8/binaries/apache-maven-3.9.8-bin.tar.gz
COPY jdk-11.0.22_linux-x64_bin.tar.gz .
RUN tar -zxf apache-tomcat-9.0.91.tar.gz
RUN tar -zxf apache-maven-3.9.8-bin.tar.gz
RUN tar -zxf jdk-11.0.22_linux-x64_bin.tar.gz
RUN mv -f apache-tomcat-9.0.91.tar.gz/* /opt/download/extract/tomcat
RUN mv -f apache-maven-3.9.8/* /opt/download/extract/maven 
RUN mv -f jdk-11.0.22/* /opt/download/java
RUN rm -rf jdk-11.0.22_linux-x64_bin.tar.gz jdk-11.0.22
RUN rm -rf apache-maven-3.9.8-bin.tar.gz apache-maven-3.9.8
RUN rm -rf apache-tomcat-9.0.91.tar.gz apache-tomcat-9.0.91
WORKDIR /
ENV JAVA_HOME=/opt/download/extract/java
ENV M2_HOME=/opt/download/extract/maven
ENV PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH
RUN mkdir /Script
WORKDIR /Script
COPY create_mvn_folder.sh .
ADD git_add.sh .
RUN chmod 755 create_mvn_folder.sh
RUN chmod 755 git_add.sh
WORKDIR /
