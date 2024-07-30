FROM docker.io/centos:centos7
RUN yum install httpd -y
COPY /home/kunalshiwarkar/tabletennis/src/main/webapp/index.html /var/www/html/index.html
COPY /home/kunalshiwarkar/tabletennis/src/main/webapp/script.js /var/www/html/
COPY /home/kunalshiwarkar/tabletennis/src/main/webapp/styles.css /var/www/html/
COPY /home/kunalshiwarkar/tabletennis/src/main/webapp/wallpaper.jpg /var/www/html/
copy /home/kunalshiwarkar/tabletennis/src/main/webapp/WEB-INF /var/www/html/
EXPOSE 80/tcp
WORKDIR /NODE
CMD ["httpd","-D","FOREGROUND"]
