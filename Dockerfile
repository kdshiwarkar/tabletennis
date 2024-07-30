FROM httpd:latest
COPY target/tabletennis.war /var/www/html
EXPOSE 80
CMD ["httpd-foreground"]
