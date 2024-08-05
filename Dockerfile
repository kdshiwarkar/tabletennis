FROM ubuntu:latest
MAINTAINER kdshiwarkar@gmail.com

# create directory 
WORKDIR /opt/download/

# update package list
RUN apt-get update

# upgrade package list
RUN apt-get -y upgrade

# install package
RUN apt-get install -y git
RUN apt-get install -y vim
RUN apt-get update
RUN apt-get install -y wget

# download tomcat,maven,java
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.91/bin/apache-tomcat-9.0.91.tar.gz
RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.8/binaries/apache-maven-3.9.8-bin.tar.gz
RUN wget https://download.oracle.com/java/22/latest/jdk-22_linux-x64_bin.tar.gz

# extract tar file 
RUN tar -xvf apache-tomcat-9.0.91.tar.gz 
RUN tar -xvf apache-maven-3.9.8-bin.tar.gz  
RUN tar -xvf jdk-22_linux-x64_bin.tar.gz 

# Set environment variables
RUN echo JAVA_HOME /opt/download/jdk-22.0.2 > .bashrc
ENV M2_HOME /opt/download/apache-maven-3.9.8
ENV PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH

#ADD war file
ADD /home/kunalshiwarkar/.jenkins/workspace/tabletennis/src/target/tabletennis.war /opt/download/apache-tomcat-9.0.91/webapps/

# Start Tomcat on container startup
CMD ["/opt/download/apache-tomcat-9.0.91/bin/startup.sh"]

EXPOSE 8080
