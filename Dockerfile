
# Use an official CentOS 7 image as a base
FROM centos:7

# Install HTTPD
RUN yum install -y httpd

# Expose the port that HTTPD will use
EXPOSE 80

# Copy the default HTTPD configuration file
COPY httpd.conf /etc/httpd/conf/httpd.conf

# Copy the index.html file to the document root
COPY index.html /var/www/html/

# Run the command to start HTTPD when the container launches
CMD ["httpd", "-D", "FOREGROUND"]
