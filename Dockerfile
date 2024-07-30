FROM httpd:latest

# No need to install httpd as it's already available in the base image
# RUN yum install httpd -y

# Copy files to the correct location
COPY /home/kunalshiwarkar/tabletennis/src/main/webapp/index.html /usr/local/apache2/htdocs/index.html
COPY /home/kunalshiwarkar/tabletennis/src/main/webapp/script.js /usr/local/apache2/htdocs/
COPY /home/kunalshiwarkar/tabletennis/src/main/webapp/styles.css /usr/local/apache2/htdocs/
COPY /home/kunalshiwarkar/tabletennis/src/main/webapp/wallpaper.jpg /usr/local/apache2/htdocs/
COPY /home/kunalshiwarkar/tabletennis/src/main/webapp/WEB-INF /usr/local/apache2/htdocs/

# Expose the port
EXPOSE 80/tcp

# Change the working directory (not sure what you're trying to do with /NODE)
WORKDIR /usr/local/apache2

# Run the httpd command
CMD ["httpd","-D","FOREGROUND"]
